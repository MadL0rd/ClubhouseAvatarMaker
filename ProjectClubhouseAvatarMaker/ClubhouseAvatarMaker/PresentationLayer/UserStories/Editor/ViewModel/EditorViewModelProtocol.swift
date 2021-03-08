//
//  EditorViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

protocol EditorViewModelProtocol: class {
    
    var defaults: UserDefaultsEditorManagerProtocol! { get }
    var bordersGroups: [BordersGroupProtocol] { get }
    var colors: [UIColor] { get }
    var authorizationStatusIsOK: Bool { get }
    var canLoadNextPage: Bool { get }
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void)
    func openSettings()
    func checkSubscriptionsStatus(force: Bool, _ completionHandler: @escaping(SubscriptionVerification) -> Void)
    
    func loadBrandedBorders(completion: @escaping() -> Void)
    func loadNextPage(completion: @escaping() -> Void)
}

extension EditorViewModelProtocol {
    func checkSubscriptionsStatus(_ completionHandler: @escaping(SubscriptionVerification) -> Void) {
        checkSubscriptionsStatus(force: false, completionHandler)
    }

}
