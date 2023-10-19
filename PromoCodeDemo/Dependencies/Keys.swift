//
//  Keys.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import Dependencies

extension ViewFactory: DependencyKey {
    public static var liveValue: ViewFactory { .init() }
}


extension PurchaseManager: DependencyKey {
    public static var liveValue: PurchaseManager = .init()
}

extension AsyncThrowableViewModel: DependencyKey  {
    public static var liveValue: AsyncThrowableViewModel<E> { Self() }
}
