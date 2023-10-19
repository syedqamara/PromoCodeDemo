//
//  Architecture.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import SwiftUI
import StoreKit

public enum PremiumType: String, CaseIterable {
    case free, basic, golden, platinum
    
    /// Initializes a `PremiumType` based on a given `SubscriptionProducts`.
    /// - Parameter subscription: The subscription product to map to a premium type.
    public init(subscription: SubscriptionProducts) {
        switch subscription {
        case .weekly:
            self = .basic
        case .monthly:
            self = .golden
        case .yearly:
            self = .platinum
        }
    }
    
    /// Maps the current premium type to a subscription product.
    var subscription: SubscriptionProducts? { .init(premium: self) }
    
    /// A user-friendly text representation of the premium type.
    var text: String {
        switch self {
        case .free:
            return "Freemium"
        case .basic:
            return "Basic Premium"
        case .golden:
            return "Golden Premium"
        case .platinum:
            return "Platinum Premium"
        }
    }
}

public enum SubscriptionProducts: String {
    case weekly = "product_weekly"
    case monthly = "product_monthly"
    case yearly = "product_yearly"
    
    /// Initializes a `SubscriptionProducts` based on a given `PremiumType`.
    /// - Parameter premium: The premium type to map to a subscription product.
    public init?(premium: PremiumType) {
        switch premium {
        case .free:
            return nil
        case .basic:
            self = .weekly
        case .golden:
            self = .monthly
        case .platinum:
            self = .yearly
        }
    }
    
    /// Maps the current subscription product to a premium type.
    public var premium: PremiumType { .init(subscription: self) }
}

/// Protocol for data sourcing components.
public protocol DataSourcing {}

/// Protocol for view models.
public protocol ViewModeling { }

/// Protocol for observable view models.
public protocol ObservableViewModel: ViewModeling, ObservableObject { }

/// Protocol for views with associated view models.
public protocol Viewing: View {
    associatedtype VM: ViewModeling
    
    /// Initializes a view with a view model.
    /// - Parameter viewModel: The associated view model.
    init(viewModel: VM)
}

/// Protocol for asynchronous, throwable view models.
public protocol AsyncThrowableViewModeing: ObservableViewModel {
    associatedtype ErrorType: Error
    
    /// An error that may occur during asynchronous operations.
    var error: ErrorType? { get set }
    
    /// A flag indicating whether the view model is currently loading data.
    var isLoading: Bool { get set }
    
    /// Initializes the asynchronous throwable view model.
    init()
}

/// Protocol for creating views dynamically.
public protocol ViewingFactory {
    /// Creates a view with the specified input.
    /// - Parameter input: The input required for creating the view.
    func makeView<I>(input: I) -> any Viewing
}

/// Protocol representing a feature in the application.
public protocol Feature {
    /// The name of the feature.
    var name: String { get }
    
    /// A list of premium types required to access the feature.
    var requiredPremiums: [PremiumType] { get }
}
