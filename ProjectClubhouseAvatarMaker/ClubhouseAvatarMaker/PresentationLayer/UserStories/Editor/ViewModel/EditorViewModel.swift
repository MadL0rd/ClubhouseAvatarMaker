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

