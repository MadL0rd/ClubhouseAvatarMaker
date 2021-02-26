//
//  SubscriptionViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import Foundation
import StoreKit

final class SubscriptionViewModel {
    
	var output: SubscriptionOutput?
    var purchaseManager: PurchaseManagerProtocol!

    private let yearText = NSLocalizedString("year", comment: "")
    private let weekText = NSLocalizedString("week", comment: "")
    private let thenText = NSLocalizedString("then", comment: "")
    
    private var yearProduct: SKProduct?
    private var weekProduct: SKProduct?
}

// MARK: - Configuration
extension SubscriptionViewModel: CustomizableSubscriptionViewModel {

}

// MARK: - Interface for view
extension SubscriptionViewModel: SubscriptionViewModelProtocol {
    
    var termsOfUsageUrl: URL? {
        return URL(string: "http://80.78.247.50/static/TermsConditions.html")
    }
    var privacyPolicyUrl: URL? {
        return URL(string: "http://80.78.247.50/static/PrivacyPolicy.html")
    }
    
    func loadYearlySubscriptionPricelabel(_ completion: @escaping(String) -> Void) {
        purchaseManager.getSubscribtionInfo(.yearly) { [ weak self ] product in
            guard let self = self
            else { return }
            self.yearProduct = product
            var text = "\(product.localizedPrice) / \(self.yearText)"
            if #available(iOS 12.2, *) {
                if let discount = product.discounts.first {
                    text = "\(discount.localizedSubscriptionPeriod) \(discount.localizedPrice) \(self.thenText) \(text)"
                }
            }
            completion(text)
        }
    }
    
    func loadWeeklySubscriptionPricelabel(_ completion: @escaping(String) -> Void) {
        purchaseManager.getSubscribtionInfo(.weekly) { [ weak self ] product in
            guard let self = self
            else { return }
            self.weekProduct = product
            var text = "\(product.localizedPrice) / \(self.weekText)"
            if #available(iOS 12.2, *) {
                if let discount = product.discounts.first {
                    text = "\(discount.localizedSubscriptionPeriod) \(discount.localizedPrice) \(self.thenText) \(text)"
                }
            }
            completion(text)
        }
    }
    
    func purchaseSubscription(_ productId: SubscriptionsId, callback: @escaping (Bool) -> Void) {
        purchaseManager.purchaseSubscription(productId) { result in
            switch result {
            case .success(let isActive):
                if isActive == .active {
                    callback(true)
                    return
                }
            case .failure(let error):
                print(error)
            }
            callback(false)
        }
    }
    
    func purchaseSubscription(_ product: SKProduct, callback: @escaping(Bool) -> Void) {
        purchaseManager.purchaseSubscription(product) { result in
            switch result {
            case .success(let isActive):
                if isActive == .active {
                    callback(true)
                    return
                }
            case .failure(let error):
                print(error)
            }
            callback(false)
        }
    }
    
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion) {
        purchaseManager.restorePurchases(callback)
    }
}

