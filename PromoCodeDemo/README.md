# Protocol Documentation

This documentation outlines a set of Swift protocols that serve as a foundation for building flexible and modular components within applications. These protocols address various aspects of structuring views, view models, and interactions.

## Introduction

The protocols are categorized into three sections:

1. **Basic Protocols:**
    - DataSourcing
    - ViewModeling
    - ObservableViewModel
    - Viewing
    - AsyncThrowableViewModeing
    - ViewingFactory

2. **Product-Related Protocols:**
    - PurchaseManaging
    - ProductListViewing and ProductListViewModeling
    - ProductDetailViewing and ProductDetailViewModeling

3. **Feature List Protocols:**
    - Feature
    - FeatureListViewing and FeatureListViewModeling

The purpose of these protocols is to create a modular and maintainable architecture for building applications. Below, you'll find example implementations, usage scenarios, and test cases for each protocol.

## Basic Protocols

### DataSourcing

The `DataSourcing` protocol indicates a data source for components in an application.

```swift
public protocol DataSourcing {}
```

### ViewModeling

The `ViewModeling` protocol represents a basic view model.

```swift
public protocol ViewModeling { }
```

### ObservableViewModel

The `ObservableViewModel` protocol extends `ViewModeling` and allows view models to be observed for changes in their properties. It conforms to the `ObservableObject` protocol.

```swift
public protocol ObservableViewModel: ViewModeling, ObservableObject { }
```

### Viewing

The `Viewing` protocol defines views with associated view models. It includes an associated type `VM` representing the view model required by the view.

```swift
public protocol Viewing: View {
    associatedtype VM: ViewModeling

    init(viewModel: VM)
}
```

### AsyncThrowableViewModeing

The `AsyncThrowableViewModeing` protocol extends `ObservableViewModel` and is designed for asynchronous operations that can throw errors. It includes properties for error handling and loading indicators.

```swift
public protocol AsyncThrowableViewModeing: ObservableViewModel {
    associatedtype ErrorType: Error

    var error: ErrorType? { get set }
    var isLoading: Bool { get set }

    init()
}
```

### ViewingFactory

The `ViewingFactory` protocol represents a factory for dynamically creating views based on input. It provides a generic method `makeView` to instantiate a view conforming to the `Viewing` protocol.

```swift
public protocol ViewingFactory {
    func makeView<I>(input: I) -> some Viewing
}
```

## Product-Related Protocols

### Purchase Managing

The `PurchaseManaging` protocol defines the requirements for a purchase manager, allowing users to interact with premium subscriptions and in-app purchases.

```swift
// Example Implementation Code
public protocol PurchaseManaging: ObservableViewModel {
    var premium: PremiumType { get }
    var availableProducts: [SubscriptionProducts] { get }

    func products() async throws -> [Product]
    func restorePurchases() async throws
    func purchase(product: Product) async throws
    func applyPromo(product: Product) async throws
}
```

#### Example Usage

```swift
let purchaseManager = PurchaseManager()
let purchaseView = PurchaseView(viewModel: purchaseManager)
```

#### Example Test Cases

```swift
func testPurchaseManager() {
    let purchaseManager = PurchaseManager()
    // Test various purchase and error scenarios.
}
```

### Product List Protocols

The `ProductListViewing` and `ProductListViewModeling` protocols define the requirements for a view and its view model to display a list of products.

```swift
// Example Implementation Code
public protocol ProductListViewing: Viewing {}
public protocol ProductListViewModeling: ObservableViewModel {
    var products: [ProductUIModel] { get }
    func fetchProducts()
}
```

#### Example Usage

```swift
let productListViewModel = ProductListViewModel()
let productListView = ProductListView(viewModel: productListViewModel)
```

#### Example Test Cases

```swift
func testProductListViewModel() {
    let productListViewModel = ProductListViewModel()
    // Test product list population and data retrieval.
}
```

### Product Detail Protocols

The `ProductDetailViewing` and `ProductDetailViewModeling` protocols define the requirements for a view and its view model to display details of a specific product.

```swift
// Example Implementation Code
public protocol ProductDetailViewing: Viewing {}
public protocol ProductDetailViewModeling: ObservableViewModel {
    var product: ProductUIModel { get }
    func purchase()
    func applyPromo()
}
```

#### Example Usage

```swift
let productDetailViewModel = ProductDetailViewModel(product: selectedProduct)
let productDetailView = ProductDetailView(viewModel: productDetailViewModel)
```

#### Example Test Cases

```swift
func testProductDetailViewModel() {
    let productDetailViewModel = ProductDetailViewModel(product: selectedProduct)
    // Test displaying product details, initiating a purchase, and applying a promo code.
}
```

## Feature List Protocols

### Feature

The `Feature` protocol represents a feature within the application and defines its name and required premium types.

```swift
// Example Implementation Code
public protocol Feature {
    var name: String { get }
    var requiredPremiums: [PremiumType] { get }
}
```

### Feature List Protocols

The `FeatureListViewing` and `FeatureListViewModeling` protocols define the requirements for a view and its view model to display a list of app features.

```swift
// Example Implementation Code
public protocol FeatureListViewing: Viewing {}
public protocol FeatureListViewModeling: ObservableViewModel {
    associatedtype AsyncThrow: AsyncThrowableViewModeing
    var asyncThrowVM: AsyncThrow { get set }
    var premium: PremiumType { get }
    var features: [Feature] { get }
    
    func featureImage(feature: Feature) -> Assets.Image
    func featurePremium(feature: Feature) -> String
    func products(for feature: Feature) -> [ProductUIModel]
}
```

#### Example Usage

```swift
let featureListViewModel = FeatureListViewModel()
let featureListView = FeatureListView(viewModel: featureListViewModel)
```

#### Example Test Cases

```swift
func testFeatureListViewModel() {
    let featureListViewModel = FeatureListViewModel()
    // Test displaying features, images, premium status, and associated products.
}
```

These code comments provide an overview of each protocol's purpose,
