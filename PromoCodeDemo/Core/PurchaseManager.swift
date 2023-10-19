//
//  PurchaseManager.swift
//  PromoCodeDemo
//
//  Created by Apple on 19/10/2023.
//

import Foundation
import StoreKit
import Dependencies

class PurchaseManager: NSObject, PurchaseManaging {
    enum PurchaseError: Error {
    case userCancelled, duplicatePurchase, failedWithNoReason
    }
    @Published var availableProducts: [SubscriptionProducts] = [ .weekly, .monthly, .yearly ]
    @Published var premium: PremiumType = .free
    private var lastFetchProducts: [Product]? = nil
    @Published public var isRequestingAlready: Bool = false
    private var updates: Task<Void, Never>? = nil
    
    @Dependency(\.productsAsyncThrow) private var productsAsyncThrow
    
    override init() {
        super.init()
        self.updates = observeTransactionUpdates()
        SKPaymentQueue.default().add(self)
    }

    deinit {
        self.updates?.cancel()
    }
    func restorePurchases() async throws {
        guard !isRequestingAlready else {
            return
        }
        isRequestingAlready.on()
        try await AppStore.sync()
        isRequestingAlready.off()
    }
    
    func updatePurchasedProducts() async {
        guard !isRequestingAlready else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                Task {
                    await self.updatePurchasedProducts()
                }
            }
            return
        }
        isRequestingAlready.on()
        var subscriptions: [PremiumType] = []
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            guard let product = SubscriptionProducts(rawValue: transaction.productID) else {
                continue
            }
            if transaction.revocationDate == nil {
                subscriptions.append(.init(subscription: product))
            }
        }
        let platinums = subscriptions.filter { $0 == .platinum }
        let goldens = subscriptions.filter { $0 == .golden }
        let basics = subscriptions.filter { $0 == .basic }
        if let value = platinums.first {
            self.premium = value
        }
        else if let value = goldens.first {
            self.premium = value
        }
        else if let value = basics.first {
            self.premium = value
        } else {
            self.premium = .free
        }
        isRequestingAlready.off()
    }
    
    func products() async throws -> [Product] {
        if let lastFetchProducts {
            return lastFetchProducts
        }
        guard !isRequestingAlready else {
            return []
        }
        isRequestingAlready.on()
        let products = try await Product.products(subscriptions: availableProducts)
        lastFetchProducts = products
        isRequestingAlready.off()
        return products
    }
    func purchase(product: Product) async throws {
        guard !isRequestingAlready else {
            return
        }
        guard let purchased = SubscriptionProducts(rawValue: product.id) else {
            return
        }
        guard purchased.premium != premium else {
            throw PurchaseError.duplicatePurchase
        }
        isRequestingAlready.on()
        let result = try await product.purchase()
        isRequestingAlready.off()
        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            print("Transaction Successfull")
            await transaction.finish()
            await updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            print("Transaction Unverified")
            throw error
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            print("Transaction Pending")
            break
        case .userCancelled:
            // ^^^
            print("Transaction Cancelled")
            throw PurchaseError.userCancelled
        @unknown default:
            break
        }
    }
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                await self.updatePurchasedProducts()
            }
        }
    }
    func applyPromo(product: Product) async throws {
        
        SKPaymentQueue.default().presentCodeRedemptionSheet()
        
        
    }
}

extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchased, .restored:
                    Task {
                        await self.updatePurchasedProducts()
                    }
                case .failed:
                    // Handle failed transactions
                    // ...
                    productsAsyncThrow.error = .custom(PurchaseError.failedWithNoReason)
                case .purchasing:
                    break
                case .deferred:
                    productsAsyncThrow.error = .custom(PurchaseError.userCancelled)
                    break
                @unknown default:
                    break
                }
            }
        }
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}
