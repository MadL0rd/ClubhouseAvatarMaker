//
//  SKProduct+localizedPrice.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 25.02.2021.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}

extension SKProductDiscount {
    var localizedPrice: String {
        if price == NSDecimalNumber(decimal: 0.00) {
                return NSLocalizedString("free", comment: "")
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
