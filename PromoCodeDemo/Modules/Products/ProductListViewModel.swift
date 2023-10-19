//
//  ProductListViewModel.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import Dependencies
import Combine

public class ProductListViewModel: ProductListViewModeling {
    public enum ErrorType: Error {
        case custom(Error?)
    }
    @Published public var products: [ProductUIModel] = []
    @Dependency(\.purchaseManager) private var purchaseManager
    @Dependency(\.productsAsyncThrow) private var asyncThrowVM
    private var cancellables: Set<AnyCancellable> = []
    init(products: [ProductUIModel]) {
        self.products = products
    }
    public func fetchProducts() {
        asyncThrowVM.isLoading.on()
        Task { [weak self] in
            guard let welf = self else { return }
            do {
                let products = try await welf.purchaseManager.products()
                DispatchQueue.main.async { [weak self] in
                    guard let welf = self else { return }
                    welf.products = products.map { .init(product: $0) }
                    welf.asyncThrowVM.isLoading.off()
                }
            }
            catch let error {
                DispatchQueue.main.async { [weak self] in
                    guard let welf = self else { return }
                    welf.asyncThrowVM.error = .custom(error)
                    welf.asyncThrowVM.isLoading.off()
                }
                
            }
        }
    }
}
