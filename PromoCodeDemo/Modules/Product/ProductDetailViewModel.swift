//
//  ProductDetailViewModel.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import Dependencies
import Combine

public class ProductDetailViewModel: ProductDetailViewModeling {
    public enum ErrorType: Error {
        case promoFailed
        case productNotFound
        case custom(Error)
    }
    @Published public var product: ProductUIModel
    @Dependency(\.productAsyncThrow) private var asyncThrowVM
    @Dependency(\.purchaseManager) private var purchaseManager
    private var cancellables: Set<AnyCancellable> = []
    init(product: ProductUIModel) {
        self.product = product
    }
    public func purchase() {
        self.asyncThrowVM.isLoading.on()
        Task { [weak self] in
            guard let welf = self else { return }
            do {
                if let prod = try await welf.purchaseManager.products().filter({ $0.id == product.id }).first {
                    try await welf.purchaseManager.purchase(product: prod)
                    DispatchQueue.main.async {
                        welf.asyncThrowVM.isLoading.off()
                    }
                } else {
                    DispatchQueue.main.async {
                        welf.asyncThrowVM.isLoading.off()
                        welf.asyncThrowVM.error = ErrorType.productNotFound
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    welf.asyncThrowVM.isLoading.off()
                    welf.asyncThrowVM.error = ErrorType.custom(error)
                }
            }
        }
    }
    
    public func applyPromo() {
        self.asyncThrowVM.isLoading.on()
        Task { [weak self] in
            guard let welf = self else { return }
            do {
                if let prod = try await welf.purchaseManager.products().filter({ $0.id == product.id }).first {
                    try await welf.purchaseManager.applyPromo(product: prod)
                    DispatchQueue.main.async {
                        welf.asyncThrowVM.isLoading.off()
                    }
                } else {
                    DispatchQueue.main.async {
                        welf.asyncThrowVM.isLoading.off()
                        welf.asyncThrowVM.error = ErrorType.productNotFound
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    welf.asyncThrowVM.isLoading.off()
                    welf.asyncThrowVM.error = ErrorType.custom(error)
                }
            }
        }
    }
}
