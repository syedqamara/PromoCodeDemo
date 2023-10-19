# PremiumType

## **Introduction:**
The `PremiumType` enum represents different premium levels available in the application, including "free," "basic," "golden," and "platinum." It provides methods for initializing from `SubscriptionProducts`, mapping to `SubscriptionProducts`, and obtaining a user-friendly text representation.

## **Usage:**
- Create instances of `PremiumType` to represent the user's premium status.
- Utilize the provided mapping functions to translate between `PremiumType` and `SubscriptionProducts`.
- Retrieve the user-friendly text representation of the premium type using the `text` property.

## **Testing Example:**
```swift
// Example Usage
let userPremium = PremiumType.basic
let correspondingSubscription = userPremium.subscription
let premiumText = userPremium.text

// Testing
assert(correspondingSubscription == SubscriptionProducts.weekly)
assert(premiumText == "Basic Premium")
```

---

# SubscriptionProducts

## **Introduction:**
The `SubscriptionProducts` enum represents different subscription products available for purchase, including "weekly," "monthly," and "yearly." It provides methods for initializing from `PremiumType` and mapping to `PremiumType`.

## **Usage:**
- Create instances of `SubscriptionProducts` to represent available subscription options.
- Utilize the provided mapping functions to translate between `SubscriptionProducts` and `PremiumType`.

## **Testing Example:**
```swift
// Example Usage
let selectedSubscription = SubscriptionProducts.monthly
let correspondingPremium = selectedSubscription.premium

// Testing
assert(correspondingPremium == PremiumType.golden)
```

---

# DataSourcing

## **Introduction:**
The `DataSourcing` protocol is an interface for components responsible for data sourcing. It does not define any specific methods but serves as a marker protocol for data-related components.

## **Usage:**
- Conform to the `DataSourcing` protocol in your data sourcing components.

## **Testing Example:**
```swift
// Example Usage
struct MyDataSource: DataSourcing {
    // Implement data sourcing methods
}

// Testing
let dataSource = MyDataSource()
// Test data sourcing functionality
```

---

# ViewModeling

## **Introduction:**
The `ViewModeling` protocol is an interface for view model components. It does not define any specific methods but serves as a marker protocol for view model components.

## **Usage:**
- Conform to the `ViewModeling` protocol in your view model components.

## **Testing Example:**
```swift
// Example Usage
struct MyViewModel: ViewModeling {
    // Implement view model functionality
}

// Testing
let viewModel = MyViewModel()
// Test view model functionality
```

---

# ObservableViewModel

## **Introduction:**
The `ObservableViewModel` protocol is an interface for view models that need to be observable. It extends the `ViewModeling` protocol and requires conformance to the `ObservableObject` protocol.

## **Usage:**
- Conform to the `ObservableViewModel` protocol when creating view models that need to be observed for changes.

## **Testing Example:**
```swift
// Example Usage
class MyObservableViewModel: ObservableViewModel {
    @Published var data: String = "Initial Data"
}

// Testing
let observableViewModel = MyObservableViewModel()
// Observe and test changes to data
```

---

# Viewing

## **Introduction:**
The `Viewing` protocol is an interface for views with associated view models. It requires conformance to the `View` protocol and defines an associated type `VM` for the view model.

## **Usage:**
- Conform to the `Viewing` protocol when creating views that require an associated view model.
- Implement the required initializer to pass the view model.

## **Testing Example:**
```swift
// Example Usage
struct MyView: Viewing {
    typealias VM = MyViewModel

    init(viewModel: MyViewModel) {
        // Initialize the view with the provided view model
    }
}

// Testing
let viewModel = MyViewModel()
let myView = MyView(viewModel: viewModel)
// Verify that the view is correctly associated with the view model
```

---

# AsyncThrowableViewModeing

## **Introduction:**
The `AsyncThrowableViewModeing` protocol is an interface for asynchronous, throwable view models. It extends the `ObservableViewModel` protocol and adds properties for handling errors and loading state.

## **Usage:**
- Conform to the `AsyncThrowableViewModeing` protocol when creating view models that handle asynchronous operations with possible errors.

## **Testing Example:**
```swift
// Example Usage
class MyAsyncViewModel: AsyncThrowableViewModeing {
    @Published var data: String = "Initial Data"
    @Published var error: MyError? = nil
    @Published var isLoading: Bool = false
}

// Testing
let asyncViewModel = MyAsyncViewModel()
// Test asynchronous operations and error handling
```

---

# ViewingFactory

## **Introduction:**
The `ViewingFactory` protocol is an interface for creating views dynamically. It defines a single method for creating views based on input parameters.

## **Usage:**
- Conform to the `ViewingFactory` protocol when you need to create views dynamically.
- Implement the `makeView` method to provide the logic
