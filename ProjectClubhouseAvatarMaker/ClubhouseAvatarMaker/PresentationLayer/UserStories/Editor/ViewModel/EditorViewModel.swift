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

    private var subscriptionIsActive: SubscriptionVerification?
    
    var borders = [
        Border(image: UIImage(), colorable: false, title: NSLocalizedString("Empty", comment: "")),
        Border(image: R.image.border1(), colorable: false, title: nil),
        Border(image: R.image.border2(), colorable: false, title: nil),
        Border(image: R.image.border3(), colorable: false, title: nil),
        Border(image: R.image.border4(), colorable: false, title: nil),
        Border(image: R.image.border5(), colorable: false, title: nil),
        Border(image: R.image.border6(), colorable: false, title: nil),
        Border(image: R.image.colorableBorder1(), colorable: true, title: nil),
        Border(image: R.image.colorableBorder2(), colorable: true, title: nil),
        Border(image: R.image.colorableBorder3(), colorable: true, title: nil),
        Border(image: R.image.colorableBorder4(), colorable: true, title: nil),
        Border(image: R.image.border7(), colorable: false, title: nil),
        Border(image: R.image.border8(), colorable: false, title: nil),
        Border(image: R.image.border9(), colorable: false, title: nil),
        Border(image: R.image.border10(), colorable: false, title: nil),
        Border(image: R.image.border11(), colorable: false, title: nil),
        Border(image: R.image.border12(), colorable: false, title: nil),
        Border(image: R.image.border13(), colorable: false, title: nil),
        Border(image: R.image.border14(), colorable: false, title: "JoJo"),
        Border(image: R.image.catBorder(), colorable: false, title: "* chpok *")
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
                print(error)
                self.subscriptionIsActive = nil
            }
        }
    }
}

