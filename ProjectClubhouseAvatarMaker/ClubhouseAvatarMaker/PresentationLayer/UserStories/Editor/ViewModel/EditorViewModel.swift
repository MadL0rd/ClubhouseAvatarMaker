//
//  EditorViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

final class EditorViewModel {
	var output: EditorOutput?
    
    var assetsManager: AssetsManagerProtocol!
    
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
        Border(image: R.image.border14(), colorable: false, title: "JoJo")
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
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void) {
        assetsManager.getSinglePhoto(completionHandler)
    }
}

