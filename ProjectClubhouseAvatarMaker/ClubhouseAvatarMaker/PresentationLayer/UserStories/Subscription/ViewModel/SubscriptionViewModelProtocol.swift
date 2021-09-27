//
//  SubscriptionViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import Foundation

protocol SubscriptionViewModelProtocol: AnyObject {
    
    var output: SubscriptionOutput? { get }
    
    var termsOfUsageUrl: URL? { get }
    var privacyPolicyUrl: URL? { get }
    
    func loadYearlySubscriptionPricelabel(_ completion: @escaping(String) -> Void)
    func loadWeeklySubscriptionPricelabel(_ completion: @escaping(String) -> Void)
    func purchaseSubscription(_ productId: SubscriptionsId, callback: @escaping(Bool) -> Void)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
}
