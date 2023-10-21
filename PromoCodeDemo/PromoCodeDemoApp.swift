//
//  PromoCodeDemoApp.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import SwiftUI
import Dependencies
import StoreKit

@main
struct PromoCodeDemoApp: App {
    @Dependency(\.viewFactory) var factory
    @Dependency(\.purchaseManager) private var purchaseManager
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AnyView(
                    factory.makeView(
                        input: .features(
                            features: [
                                FreeFeature(),
                                BasicFeature(),
                                GoldenFeature(),
                                PlatinumFeature()
                            ]
                        )
                    )
                )
            }
        }
    }
}
