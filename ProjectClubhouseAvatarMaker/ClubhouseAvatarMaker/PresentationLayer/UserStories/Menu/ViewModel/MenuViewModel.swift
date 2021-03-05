//
//  MenuViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import Foundation
import UIKit

final class MenuViewModel {
    
	var output: MenuOutput?
    var purchaseManager: PurchaseManagerProtocol!
    
}

// MARK: - Configuration
extension MenuViewModel: CustomizableMenuViewModel {

}

// MARK: - Interface for view
extension MenuViewModel: MenuViewModelProtocol {

    var termsOfUsageUrl: URL? {
        return purchaseManager.termsOfUsageUrl
    }
    var privacyPolicyUrl: URL? {
        return purchaseManager.privacyPolicyUrl
    }
    var supportUrl: URL? {
        return purchaseManager.supportUrl
    }
    
    func rateApp() {
        purchaseManager.rateApp()
    }
    
    func checkSubscriptionsStatus(_ completionHandler: @escaping(SubscriptionVerification) -> Void) {
        purchaseManager.checkActiveSubscriptions { result in
            switch result {
            case .success(let isActive):
                completionHandler(isActive)
                
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.notPurchased)
            }
        }
    }
    
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion) {
        purchaseManager.restorePurchases(callback)
    }
}

