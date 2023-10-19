//
//  FeatureUnlockView.swift
//  PromoCodeDemo
//
//  Created by Apple on 19/10/2023.
//

import SwiftUI

struct FeatureUnlockView<V: View>: View {
    private var contentView: V
    var premium: PremiumType
    init(premium: PremiumType, @ViewBuilder contentView: () -> V) {
        self.premium = premium
        self.contentView = contentView()
    }
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            contentView
            Text("Congratulation for Unlocking \(premium.text)")
                .font(.headline)
                .foregroundColor(.init(.unlock))
        }
        .navigationTitle(premium.text)
    }
}

struct FeatureUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureUnlockView(premium: .free) {
            Text("")
        }
    }
}
