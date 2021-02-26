//
//  PurchaseManagerProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 25.02.2021.
//

import SwiftyStoreKit
import StoreKit

protocol PurchaseManagerProtocol: class {
    
    func completeTransactions()
    func checkActiveSubscriptions(_ callback: @escaping CheckActiveSubscriptionsCompletion)
    func getSubscribtionInfo(_ productId: SubscriptionsId, callback: @escaping GetSubscribtionInfoCompletion)
    func purchaseSubscription(_ productId: SubscriptionsId, callback: @escaping CheckActiveSubscriptionsCompletion)
    func purchaseSubscription(_ productId: SKProduct, callback: @escaping CheckActiveSubscriptionsCompletion)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
}
