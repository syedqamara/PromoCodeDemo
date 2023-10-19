//
//  ProductUIModel.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import StoreKit
import SwiftUI
public struct ProductUIModel: Identifiable {
    public let name: String
    public let id: String
    public let price: String
    public init(product: Product) {
        if product.displayName.isEmpty {
            let premium = PremiumType(subscription: .init(rawValue: product.id) ?? .weekly)
            self.name = premium.text
        } else {
            self.name = product.displayName
        }
        
        self.id = product.id
        self.price = product.displayPrice
        
    }
    public init(name: String, id: String, price: String) {
        self.name = name
        self.id = id
        self.price = price
    }
}

extension ProductUIModel {
    static var weeklyPreview: ProductUIModel {
        .init(
            name: "Weekly Subscription",
            id: "1",
            price: "USD 0.99"
        )
    }
    static var monthlyPreview: ProductUIModel {
        .init(
            name: "Monthly Subscription",
            id: "2",
            price: "USD 4.0 $"
        )
    }
    static var yearlyPreview: ProductUIModel {
        .init(
            name: "Yearly Subscription",
            id: "3",
            price: "USD 48.0 $"
        )
    }
}
