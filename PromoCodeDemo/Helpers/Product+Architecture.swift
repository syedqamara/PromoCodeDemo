//
//  Product+Architecture.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import StoreKit



extension Product {
    static func products(subscriptions: [SubscriptionProducts]) async throws -> [Product] {
        try await Product.products(for: subscriptions.map { $0.rawValue })
    }
    func rest() {
        Task {
            try? await self.purchase(options: [
                .appAccountToken(UUID()),
                .promotionalOffer(offerID: "", keyID: "", nonce: UUID(), signature: .init(), timestamp: 0)
            ])
        }
    }
}
extension Bool {
    mutating func on() {
        self = true
    }
    mutating func off() {
        self = false
    }
}

extension Feature {
    func allowed(for premium: PremiumType) -> Bool {
        requiredPremiums.filter { $0 == premium }.count == 1
    }
}
