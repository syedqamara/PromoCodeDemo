//
//  FeatureListView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import SwiftUI
import Dependencies

struct FeatureListView<T: FeatureListViewModeling>: FeatureListViewing {
    typealias VM = T
    @ObservedObject private var viewModel: T
    @ObservedObject private var asyncThrowVM: T.AsyncThrow
    @Dependency(\.viewFactory) var factory
    init(viewModel: T) {
        self.viewModel = viewModel
        asyncThrowVM = viewModel.asyncThrowVM
    }
    var body: some View {
        Form {
            ForEach(viewModel.features, id: \.name) { feature in
                NavigationLink {
                    if feature.allowed(for: viewModel.premium) {
                        FeatureUnlockView(premium: viewModel.premium) {
                            section(
                                title: feature.name,
                                value: viewModel.featurePremium(feature: feature),
                                image: viewModel.featureImage(feature: feature)
                            )
                        }
                        
                    } else {
                        AnyView(
                            factory.makeView(
                                input: .products(
                                    products: viewModel.products(for: feature)
                                )
                            )
                        )
                    }
                } label: {
                    section(
                        title: feature.name,
                        value: viewModel.featurePremium(feature: feature),
                        image: viewModel.featureImage(feature: feature)
                    )
                }
            }
        }
        .errorView(error: $asyncThrowVM.error)
        .loadingView(isLoading: $asyncThrowVM.isLoading)
        .navigationTitle(viewModel.premium.text)
    }
    
    @ViewBuilder
    func section(title: String, value: String, image: Assets.Image) -> some View {
        Section {
            HStack(alignment: .center) {
                Text(title)
                    .font(.headline).fontWeight(.bold)
                Spacer()
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(image.color)
                    .frame(width: 20, height: 20)
                    .padding([.horizontal], 10)
            }
            .padding([.horizontal], 10)
            .frame(height: 40)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom], 10)
    }
    
}

struct FeatureListView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var factory
    static var previews: some View {
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
