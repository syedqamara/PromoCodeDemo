//
//  Abstract.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import StoreKit


// MARK: Purchase Manager Protocol
/// The `PurchaseManaging` protocol defines the requirements for a purchase manager, allowing users to interact with premium subscriptions and in-app purchases.
public protocol PurchaseManaging: ObservableViewModel {
    var premium: PremiumType { get }
    var availableProducts: [SubscriptionProducts] { get }

    /// Retrieves a list of available products asynchronously.
    func products() async throws -> [Product]

    /// Restores user's previous purchases.
    func restorePurchases() async throws

    /// Initiates the purchase of a specific product.
    /// - Parameter product: The product to purchase.
    func purchase(product: Product) async throws

    /// Initiates a purchase using a promo code.
    /// - Parameter promo: The promo code to apply.
    func applyPromo(product: Product) async throws
}

// Example Usage:
// - A class conforming to `PurchaseManaging` can manage in-app purchases and subscriptions in an app.
// - It can provide information about available products, initiate purchases, and handle premium status.
// - Example Usage: An e-commerce app with premium subscription options.

// Example Test Cases:
// - Test retrieving available products.
// - Test restoring previous purchases.
// - Test initiating a purchase.
// - Test applying a promo code for a purchase.

// MARK: Product List Protocol
/// The `ProductListViewing` protocol defines the requirements for a view that displays a list of products.
public protocol ProductListViewing: Viewing {}

/// The `ProductListViewModeling` protocol defines the requirements for the view model of a product list view.
public protocol ProductListViewModeling: ObservableViewModel {
    var products: [ProductUIModel] { get }

    /// Fetches the list of products to be displayed.
    func fetchProducts()
}

// Example Usage:
// - A `ProductListViewing` conforming view can display a list of products in a user-friendly manner.
// - A `ProductListViewModeling` conforming view model can manage the product data and handle data retrieval.
// - Example Usage: Displaying a list of products in a shopping app.

// Example Test Cases:
// - Test populating the list of products.
// - Test fetching products from a data source.

// MARK: Product Detail Protocol
/// The `ProductDetailViewing` protocol defines the requirements for a view that displays details of a specific product.
public protocol ProductDetailViewing: Viewing {}

/// The `ProductDetailViewModeling` protocol defines the requirements for the view model of a product detail view.
public protocol ProductDetailViewModeling: ObservableViewModel {
    var product: ProductUIModel { get }

    /// Initiates the purchase of the displayed product.
    func purchase()

    /// Applies a promo code to the purchase process.
    /// - Parameter promo: The promo code to apply.
    func applyPromo()
}

// Example Usage:
// - A `ProductDetailViewing` conforming view can display detailed information about a product and enable purchasing.
// - A `ProductDetailViewModeling` conforming view model can manage the product data and purchase actions.
// - Example Usage: Viewing product details and making purchases in an e-commerce app.

// Example Test Cases:
// - Test displaying product details.
// - Test initiating a purchase of the displayed product.
// - Test applying a promo code to a purchase.

// MARK: Feature List Protocol
/// The `FeatureListViewing` protocol defines the requirements for a view that displays a list of app features.
public protocol FeatureListViewing: Viewing {}

/// The `FeatureListViewModeling` protocol defines the requirements for the view model of a feature list view.
public protocol FeatureListViewModeling: ObservableViewModel {
    associatedtype AsyncThrow: AsyncThrowableViewModeing
    var asyncThrowVM: AsyncThrow { get set }
    var premium: PremiumType { get }
    var features: [Feature] { get }

    /// Retrieves the image representing a specific feature.
    /// - Parameter feature: The feature for which the image is requested.
    /// - Returns: The image asset.
    func featureImage(feature: Feature) -> Assets.Image

    /// Retrieves the premium status associated with a feature.
    /// - Parameter feature: The feature for which the premium status is requested.
    /// - Returns: The premium status string.
    func featurePremium(feature: Feature) -> String

    /// Retrieves the products available for a specific feature.
    /// - Parameter feature: The feature for which products are requested.
    /// - Returns: An array of product UI models.
    func products(for feature: Feature) -> [ProductUIModel]
}

// Example Usage:
// - A `FeatureListViewing` conforming view can display app features, including their premium status and available products.
// - A `FeatureListViewModeling` conforming view model can manage the feature data and associated actions.
// - Example Usage: Displaying features and available products in a feature-rich app.

// Example Test Cases:
// - Test displaying features with premium status and associated products.
// - Test retrieving images for features.
// - Test retrieving premium status for features.
// - Test retrieving available products for features.

