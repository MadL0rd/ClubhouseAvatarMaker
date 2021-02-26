//
//  EditorViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

protocol EditorViewModelProtocol: class {
    
    var defaults: UserDefaultsEditorManagerProtocol! { get }
    var borders: [Border] { get }
    var colors: [UIColor] { get }
    var authorizationStatusIsOK: Bool { get }
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void)
    func openSettings()
    func checkSubscriptionsStatus(force: Bool, _ completionHandler: @escaping(SubscriptionVerification) -> Void)
}

extension EditorViewModelProtocol {
    func checkSubscriptionsStatus(_ completionHandler: @escaping(SubscriptionVerification) -> Void) {
        checkSubscriptionsStatus(force: false, completionHandler)
    }

}
