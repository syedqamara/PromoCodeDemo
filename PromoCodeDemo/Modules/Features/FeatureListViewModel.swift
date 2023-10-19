//
//  FeatureListViewModel.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import Dependencies
import Combine
import StoreKit
import SwiftUI



public class FeatureListViewModel: FeatureListViewModeling {
    @ObservedObject public var asyncThrowVM: FeaturesAsyncThrowVM
    public enum ErrorType: Error {
        case custom(Error)
    }
    @Published public var features: [Feature]
    @Published public var premium: PremiumType = .free
    
    @Dependency(\.purchaseManager) private var purchaseManager
    
    
    
    
    private var purchaseLoadingCancellables: Set<AnyCancellable> = []
    private var premiumCancellables: Set<AnyCancellable> = []
    private var products: [Product] = []
    
    public init(features: [Feature]) {
        self.features = features
        
        @Dependency(\.featuresAsyncThrow) var featureVM__
        self.asyncThrowVM = featureVM__
        
        purchaseManager.$isRequestingAlready.sink {
            [weak self]
            newValue in
            guard let welf = self else { return }
            DispatchQueue.main.async {
                welf.asyncThrowVM.isLoading = newValue
            }
        }
        .store(in: &purchaseLoadingCancellables)
        
        purchaseManager.$premium.sink {
            [weak self]
            newPremium in
            guard let welf = self else { return }
            DispatchQueue.main.async {
                welf.premium = newPremium
            }
        }
        .store(in: &premiumCancellables)
        fetchProducts()
    }
    private func fetchProducts() {
        
        self.asyncThrowVM.isLoading.on()
        Task { [weak self] in
            guard let welf = self else { return }
            do {
                welf.products = try await welf.purchaseManager.products()
                await welf.purchaseManager.updatePurchasedProducts()
                DispatchQueue.main.async {
                    welf.asyncThrowVM.isLoading.off()
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
    public func products(for feature: Feature) -> [ProductUIModel] {
        let ids = feature.requiredPremiums.map { $0.subscription }.compactMap { $0 }
        let products = ids.flatMap { id in
            let filteredProducts = self.products.filter { prod in
                prod.id == id.rawValue
            }
            .compactMap { $0 }
            .map { ProductUIModel(product: $0) }
            
            return filteredProducts
        }
        return products
    }
    public func featureImage(feature: Feature) -> Assets.Image {
        if feature.allowed(for: premium) {
            return .unlock
        }
        return .lock
    }
    public func featurePremium(feature: Feature) -> String {
        if feature.requiredPremiums.contains(.free) {
            return "Free"
        }
        else if feature.requiredPremiums.contains(.basic) {
            return "Basic"
        }
        else if feature.requiredPremiums.contains(.golden) {
            return "Golden"
        }
        else if feature.requiredPremiums.contains(.platinum) {
            return "Platinum"
        }
        return "No Premium Available"
    }
}
