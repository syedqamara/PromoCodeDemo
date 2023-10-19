//
//  ProductListView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import SwiftUI
import Dependencies

struct ProductListView<T: ProductListViewModeling>: ProductListViewing {
    typealias VM = T
    @ObservedObject private var viewModel: T
    @Dependency(\.viewFactory) var factory
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack(spacing: 10) {
            Form {
                ForEach(viewModel.products) { product in
                    AnyView(
                        factory.makeView(
                            input: .product(
                                product: product
                            )
                        )
                    )
                }
            }
        }
        .onAppear() {
            if viewModel.products.isEmpty {
                viewModel.fetchProducts()
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var factory
    static var previews: some View {
        AnyView(
            factory.makeView(
                input: .products(
                    products: [
                        .weeklyPreview,
                        .monthlyPreview,
                        .yearlyPreview
                    ]
                )
            )
        )
    }
}
