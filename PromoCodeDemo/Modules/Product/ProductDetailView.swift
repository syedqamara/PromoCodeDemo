//
//  ProductDetailView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import SwiftUI
import Dependencies

struct ProductDetailView<T: ProductDetailViewModeling>: ProductDetailViewing {
    typealias VM = T
    @ObservedObject private var viewModel: T
    @State private var promotText: String = ""
    @FocusState private var promoIsFocus: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    private var promoColor: Color {
        if promoIsFocus {
            return .black
        }
        return .gray
    }
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            section(title: "Name", value: viewModel.product.name)
            
            section(title: "Product ID", value: viewModel.product.id)
            
            section(title: "Price", value: viewModel.product.price)
            
            promoCodeView()
                .onTapGesture {
                    viewModel.applyPromo()
                }
            
            purhaseButton()
                .onTapGesture {
                    viewModel.purchase()
                }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding(10)
//        .onTapGesture {
//            promoIsFocus = false
//        }
    }
    @ViewBuilder
    func section(title: String, value: String) -> some View {
        Section {
            HStack {
                Text(title)
                    .font(.title2).fontWeight(.bold)
                Spacer()
                Text(value)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(height: 40)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom], 10)
        
    }
    
    @ViewBuilder
    func purhaseButton() -> some View {
        Section {
            Text("Purchase")
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom], 10)
    }
    
    @ViewBuilder
    func promoCodeView() -> some View {
        Section {
            Text("Apply Promo")
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .cornerRadius(10)
//            HStack {
//                TextField(text: $promotText) {
//                    Text("Enter Promo...")
//                        .font(.headline)
//                        .foregroundColor(promoColor)
//                        .padding()
//                        .background(Color.gray.opacity(0.4))
//                        .cornerRadius(10)
//                }
//                .focused($promoIsFocus)
//                .frame(height: 40)
//                .padding([.horizontal], 10)
//                .roundedRectangle(cornerRadius: 5, lineWidth: 2, strokeColor: promoColor, fillColor: promoColor.opacity(0.3))
//                Spacer()
                
//            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom], 10)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var factory
    static var previews: some View {
        AnyView(
            factory.makeView(
                input: .product(
                    product: .weeklyPreview
                )
            )
        )
    }
}
