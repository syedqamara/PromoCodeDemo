//
//  Features.swift
//  PromoCodeDemo
//
//  Created by Apple on 19/10/2023.
//

import Foundation

struct FreeFeature: Feature {
    var name: String = "Free Feature"
    var requiredPremiums: [PremiumType] = PremiumType.allCases
    init() { }
}

struct BasicFeature: Feature {
    var name: String = "Basic Feature"
    var requiredPremiums: [PremiumType] = [.basic, .golden, .platinum]
    init() { }
}

struct GoldenFeature: Feature {
    var name: String = "Golden Feature"
    var requiredPremiums: [PremiumType] = [.golden, .platinum]
    init() { }
}
struct PlatinumFeature: Feature {
    var name: String = "Platinum Feature"
    var requiredPremiums: [PremiumType] = [.platinum]
    init() { }
}
