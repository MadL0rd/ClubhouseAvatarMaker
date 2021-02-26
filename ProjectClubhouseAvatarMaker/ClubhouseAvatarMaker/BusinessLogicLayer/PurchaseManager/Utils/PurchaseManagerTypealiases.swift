//
//  PurchaseManagerTypealiases.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 25.02.2021.
//

import StoreKit

enum SubscriptionVerification {
    case active
    case notPurchased
}

enum ResoreResult {
    case failed
    case success
    case nothingToRestore
    
    var localized: String {
        switch self {
        case .failed:
            return NSLocalizedString("Failed", comment: "")
        case .success:
            return NSLocalizedString("Success", comment: "")
        case .nothingToRestore:
            return NSLocalizedString("Nothing to restore", comment: "")
        }
    }
}

typealias CheckActiveSubscriptionsCompletion = (Result<SubscriptionVerification, Error>) -> Void
typealias GetSubscribtionInfoCompletion = (SKProduct) -> Void
//typealias PurchaseSubscriptionCompletion = (Result<SubscriptionVerification, Error>) -> Void
typealias RestorePurchasesCompletion = (ResoreResult) -> Void

