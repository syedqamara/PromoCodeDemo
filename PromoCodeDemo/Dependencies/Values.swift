//
//  Values.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import Dependencies

extension DependencyValues {
    var viewFactory: ViewFactory {
        get { self[ViewFactory.self] }
        set { self[ViewFactory.self] = newValue }
    }
    var purchaseManager: PurchaseManager {
        get { self[PurchaseManager.self] }
        set { self[PurchaseManager.self] = newValue }
    }
    var productsAsyncThrow: ProductsAsyncThrowVM {
        get { self[ProductsAsyncThrowVM.self] }
        set { self[ProductsAsyncThrowVM.self] = newValue }
    }
    var productAsyncThrow: ProductAsyncThrowVM {
        get { self[ProductAsyncThrowVM.self] }
        set { self[ProductAsyncThrowVM.self] = newValue }
    }
    var featuresAsyncThrow: FeaturesAsyncThrowVM {
        get { self[FeaturesAsyncThrowVM.self] }
        set { self[FeaturesAsyncThrowVM.self] = newValue }
    }
}
