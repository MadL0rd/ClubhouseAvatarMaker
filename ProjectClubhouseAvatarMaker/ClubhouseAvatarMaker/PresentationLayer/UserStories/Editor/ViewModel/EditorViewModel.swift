//
//  EditorViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit
import SwiftyStoreKit

final class EditorViewModel {
    
	var output: EditorOutput?
    var assetsManager: AssetsManagerProtocol!
    var purchaseManager: PurchaseManagerProtocol!
    var remoteBordersService: RemoteBordersServiceProtocol!
    
    private var subscriptionIsActive: SubscriptionVerification?
    private var pageCurrentNumber = 1
    var canLoadNextPage = true
    
    var defaults: UserDefaultsEditorManagerProtocol!

    var borders: [BorderProtocol] = [
        Border(colorable: false, image: UIImage(), title: NSLocalizedString("Empty", comment: "")),
        Border(colorable: false, image: R.image.border15()),
        Border(colorable: false, image: R.image.border1()),
        Border(colorable: false, image: R.image.border2()),
        Border(colorable: false, image: R.image.border3()),
        Border(colorable: false, image: R.image.border4()),
        Border(colorable: false, image: R.image.border5()),
        Border(colorable: false, image: R.image.border6()),
        Border(colorable: true, image: R.image.colorableBorder1()),
        Border(colorable: true, image: R.image.colorableBorder2()),
        Border(colorable: true, image: R.image.colorableBorder3()),
        Border(colorable: true, image: R.image.colorableBorder4()),
        Border(colorable: false, image: R.image.border7()),
        Border(colorable: false, image: R.image.border8()),
        Border(colorable: false, image: R.image.border9()),
        Border(colorable: false, image: R.image.border10()),
        Border(colorable: false, image: R.image.border11()),
        Border(colorable: false, image: R.image.border12()),
        Border(colorable: false, image: R.image.border13()),
        Border(colorable: false, image: R.image.border14(), title: "JoJo"),
        Border(colorable: false, image: R.image.catBorder(), title: "* chpok *")
    ]
    var colors = [UIColor]()
    
    init() {
        colors = (0...360).compactMap { $0 % 15 == 0 ? colorFromDegreesAngle(CGFloat($0)) : nil }
    }
    
    private func colorFromDegreesAngle(_ angle: CGFloat) -> UIColor {
        
        var angle = Float(angle)
        while angle >= 360 {
            angle -= 360
        }
        while angle < 0 {
            angle += 360
        }
        
        let value = angle * 6 / 360
        
        let maxColorValue: Float = 1
        let minColorValue: Float = 0
        
        var red = minColorValue, blue = minColorValue, green = minColorValue
        switch value {
        case 0...1:
            red = maxColorValue
            blue = minColorValue + (maxColorValue - minColorValue) * value
            green = minColorValue
        case 1...2:
            red = maxColorValue - (maxColorValue - minColorValue) * (value - 1)
            blue = maxColorValue
            green = minColorValue
        case 2...3:
            red = minColorValue
            blue = maxColorValue
            green = minColorValue + (maxColorValue - minColorValue) * (value - 2)
        case 3...4:
            red = minColorValue
            blue = maxColorValue - (maxColorValue - minColorValue) * (value - 3)
            green = maxColorValue
        case 4...5:
            red = minColorValue + (maxColorValue - minColorValue) * (value - 4)
            blue = minColorValue
            green = maxColorValue
        case 5...6:
            red = maxColorValue
            blue = minColorValue
            green = maxColorValue - (maxColorValue - minColorValue) * (value - 5)
        default:
            break
        }
        return UIColor(red: CGFloat(red),
                       green: CGFloat(green),
                       blue: CGFloat(blue),
                       alpha: 1)
    }
    
}

// MARK: - Configuration
extension EditorViewModel: CustomizableEditorViewModel {

}

// MARK: - Interface for view
extension EditorViewModel: EditorViewModelProtocol {
    
    // MARK: - Assets
    
    var authorizationStatusIsOK: Bool {
        switch assetsManager.authorizationStatus {
        case .authorized, .limited, .notDetermined:
            return true
        case .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void) {
        assetsManager.getSinglePhoto(completionHandler)
    }
    
    func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func checkSubscriptionsStatus(force: Bool, _ completionHandler: @escaping(SubscriptionVerification) -> Void) {
        if let isActive = subscriptionIsActive,
           !force {
            completionHandler(isActive)
            return
        }
        purchaseManager.checkActiveSubscriptions { [ weak self ] result in
            guard let self = self
            else { return }
            switch result {
            case .success(let isActive):
                self.subscriptionIsActive = isActive
                completionHandler(isActive)
                
            case .failure(let error):
                print(error.localizedDescription)
                self.subscriptionIsActive = nil
                completionHandler(.notPurchased)
            }
        }
    }
    
    // MARK: - Remote borders
    
    func loadNextPage(completion: @escaping() -> Void) {
        guard canLoadNextPage
        else {
            completion()
            return
        }
        remoteBordersService.getBorders(pageNumber: pageCurrentNumber) { [ weak self ] result in
            switch result {
            case .success(let pageInfo):
                self?.borders.append(contentsOf: pageInfo.results)
                self?.canLoadNextPage = pageInfo.next != nil
                self?.pageCurrentNumber += 1
            case .failure(let error):
                print(error)
            }
            completion()
        }
    }
}

