//
//  Factory+StockExchange.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import SwiftUI
import Dependencies

extension ViewFactory {
    public enum StockExchangeViewInput {
        case none
        case product(product: ProductUIModel)
        case products(products: [ProductUIModel])
        case features(features: [Feature])
    }
    public func makeView(input: StockExchangeViewInput) -> any Viewing {
        switch input {
        case .none:
            return EmptyView()
        case .products(products: let products):
            return ProductListView(
                viewModel: ProductListViewModel(
                    products: products
                )
            )
        case .product(product: let product):
            return ProductDetailView(
                viewModel: ProductDetailViewModel(
                    product: product
                )
            )
        case .features(features: let features):
            return FeatureListView(
                viewModel: FeatureListViewModel(
                    features: features
                )
            )
        }
    }
}
