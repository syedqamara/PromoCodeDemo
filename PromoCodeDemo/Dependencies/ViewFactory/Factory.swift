//
//  Factory.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import SwiftUI
import Dependencies



public struct ViewFactory: ViewingFactory {
    public func makeView<I>(input: I) -> any Viewing {
        EmptyView(viewModel: .init())
    }
    
}

public struct EmptyViewModel: ViewModeling {}

extension EmptyView: Viewing {
    public typealias VM = EmptyViewModel
    public init(viewModel: EmptyViewModel) {
        self.init()
    }
    
}
