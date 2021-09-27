//
//  MenuViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import Foundation

protocol MenuViewModelProtocol: AnyObject {
    
    var termsOfUsageUrl: URL? { get }
    var privacyPolicyUrl: URL? { get }
    var supportUrl: URL? { get }
    
    func rateApp()
    func checkSubscriptionsStatus(_ completionHandler: @escaping(SubscriptionVerification) -> Void)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
}
