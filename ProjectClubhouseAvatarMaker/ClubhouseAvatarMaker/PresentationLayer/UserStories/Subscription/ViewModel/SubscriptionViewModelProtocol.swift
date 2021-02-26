//
//  SubscriptionViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

protocol SubscriptionViewModelProtocol: class {
    
    func loadYearlySubscriptionPricelabel(_ completion: @escaping(String) -> Void)
    func loadWeeklySubscriptionPricelabel(_ completion: @escaping(String) -> Void)
    func purchaseSubscription(_ productId: SubscriptionsId, successCallback: @escaping() -> Void)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
}
