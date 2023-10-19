//
//  Abstract.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import StoreKit


// MARK: Purchase Manager Protocol

protocol PurchaseManaging: ObservableViewModel {
    var premium: PremiumType { get }
    var availableProducts: [SubscriptionProducts] { get }
    func products() async throws -> [Product]
    func restorePurchases() async throws
    func purchase(product: Product) async throws
    func purchase(with promo: String) async throws
}

// MARK: Product List Protocol

protocol ProductListViewing: Viewing {}
protocol ProductListViewModeling: ObservableViewModel {
    var products: [ProductUIModel] { get }
    func fetchProducts()
}

// MARK: Product Detail Protocol

protocol ProductDetailViewing: Viewing {}
protocol ProductDetailViewModeling: ObservableViewModel {
    var product: ProductUIModel { get }
    func purchase()
    func applyPromo(promo: String)
}

// MARK: Feature List Protocol

protocol FeatureListViewing: Viewing {}
protocol FeatureListViewModeling: ObservableViewModel {
    associatedtype AsyncThrow: AsyncThrowableViewModeing
    var asyncThrowVM: AsyncThrow { get set }
    var premium: PremiumType { get }
    var features: [Feature] { get }
    func featureImage(feature: Feature) -> Assets.Image
    func featurePremium(feature: Feature) -> String
    func products(for feature: Feature) -> [ProductUIModel]
}
