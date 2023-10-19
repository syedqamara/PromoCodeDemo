//
//  AsyncThrowableViewModel.swift
//  PromoCodeDemo
//
//  Created by Apple on 19/10/2023.
//

import Foundation

public typealias FeaturesAsyncThrowVM = AsyncThrowableViewModel<FeatureListViewModel.ErrorType>
public typealias ProductAsyncThrowVM = AsyncThrowableViewModel<ProductDetailViewModel.ErrorType>
public typealias ProductsAsyncThrowVM = AsyncThrowableViewModel<ProductListViewModel.ErrorType>

public class AsyncThrowableViewModel<E: Error>: AsyncThrowableViewModeing {
    public typealias ErrorType = E
    @Published public var error: E? = nil
    @Published public var isLoading: Bool = false
    public required init() { }
}
