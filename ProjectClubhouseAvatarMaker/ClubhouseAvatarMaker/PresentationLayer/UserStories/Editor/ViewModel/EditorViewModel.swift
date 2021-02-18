//
//  EditorViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

final class EditorViewModel {
	var output: EditorOutput?
    
    var assetsManager: AssetsManagerProtocol!
    
    var borders = [
        Border(image: R.image.border1(), colorable: false),
        Border(image: R.image.border2(), colorable: false),
        Border(image: R.image.border3(), colorable: false),
        Border(image: R.image.border4(), colorable: false),
        Border(image: R.image.border5(), colorable: false),
        Border(image: R.image.border6(), colorable: false),
        Border(image: R.image.colorableBorder1(), colorable: true),
        Border(image: R.image.colorableBorder2(), colorable: true),
        Border(image: R.image.colorableBorder3(), colorable: true),
        Border(image: R.image.colorableBorder4(), colorable: true),
        Border(image: R.image.border7(), colorable: false),
        Border(image: R.image.border8(), colorable: false),
        Border(image: R.image.border9(), colorable: false),
        Border(image: R.image.border10(), colorable: false),
        Border(image: R.image.border11(), colorable: false),
        Border(image: R.image.border12(), colorable: false),
        Border(image: R.image.border13(), colorable: false),
        Border(image: R.image.border14(), colorable: false)
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

