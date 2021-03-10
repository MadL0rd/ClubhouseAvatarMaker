//
//  PurchaseManager.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 25.02.2021.
//

import SwiftyStoreKit
import StoreKit

class PurchaseManager: PurchaseManagerProtocol {
    
    static let shared: PurchaseManagerProtocol = PurchaseManager()

    var termsOfUsageUrl: URL? {
        return URL(string: "http://80.78.247.50/static/TermsConditions.html")
    }
    var privacyPolicyUrl: URL? {
        return URL(string: "http://80.78.247.50/static/PrivacyPolicy.html")
    }
    var supportUrl: URL? {
        return URL(string: "https://vk.com/clubhouseborderedavatar")
    }
    
    var subscriptionIsActive: SubscriptionVerification?
    
    func completeTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                print(purchase)
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }
    }
    
    func checkActiveSubscriptions(_ callback: @escaping CheckActiveSubscriptionsCompletion) {
        guard subscriptionIsActive != .active
        else {
            callback(.success(.active))
            return
        }
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { [ weak self ] result in
            switch result {
            case .success(let receipt):
                let productIds = Set(SubscriptionsId.allCases.map { $0.rawValue })
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productIds) are valid until \(expiryDate)\n\(items)\n")
                    self?.subscriptionIsActive = .active
                    callback(.success(.active))

                case .expired(let expiryDate, let items):
                    print("\(productIds) are expired since \(expiryDate)\n\(items)\n")
                    self?.subscriptionIsActive = .notPurchased
                    callback(.success(.notPurchased))
                    
                case .notPurchased:
                    print("The user has never purchased \(productIds)")
                    self?.subscriptionIsActive = nil
                    callback(.success(.notPurchased))
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                callback(.failure(error))
            }
        }
    }
    
    func getSubscribtionInfo(_ productId: SubscriptionsId, callback: @escaping GetSubscribtionInfoCompletion) {
        SwiftyStoreKit.retrieveProductsInfo([productId.rawValue]) { result in
            guard let product = result.retrievedProducts.first
            else { return }
            callback(product)
        }
    }
    
    func purchaseSubscription(_ productId: SubscriptionsId, callback: @escaping CheckActiveSubscriptionsCompletion) {
        getSubscribtionInfo(productId) { [ weak self ] product in
            self?.purchaseSubscription(product, callback: callback)
        }
    }
    
    func purchaseSubscription(_ product: SKProduct, callback: @escaping CheckActiveSubscriptionsCompletion) {
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                callback(.success(purchase.needsFinishTransaction ? .notPurchased : .active))
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
                callback(.failure(error))
                
            }
        }
    }
    
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if !results.restoreFailedPurchases.isEmpty {
                return callback(.failed)
            }
            if !results.restoredPurchases.isEmpty {
                return callback(.success)
            }
            return callback(.nothingToRestore)
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func forceSetSubscriptionActive() {
        subscriptionIsActive = .active
    }
}
