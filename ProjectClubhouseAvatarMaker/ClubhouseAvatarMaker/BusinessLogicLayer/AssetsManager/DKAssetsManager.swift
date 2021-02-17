//
//  AssetsManager.swift
//  ClipGo
//
//  Created by Антон Текутов on 11.07.2020.
//

import Photos
import UIKit
import DKImagePickerController

class DKAssetsManager: NSObject, AssetsManagerProtocol {
    
    var rootVC: UIViewController? {
        UIApplication.shared.keyWindow?.rootViewController
    }
    
    func getSinglePhoto(_ completionHandler: @escaping ( _ photo: ImageAssetProtocol) -> Void) {
        
        let pickerController = DKImagePickerController()
        
        pickerController.singleSelect = true
        pickerController.autoCloseOnSingleSelect = true
        pickerController.sourceType = .photo
        pickerController.assetType = .allPhotos
        pickerController.didSelectAssets = { assets in
            guard !assets.isEmpty,
                  let photo = assets[0].originalAsset
            else { return }
            completionHandler(photo)
        }
        
        rootVC?.present(pickerController, animated: true)
    }
    
    func getPhotosArray(maxCount: Int, completionHandler: @escaping (_ photos: [ImageAssetProtocol]) -> Void) {
        let pickerController = DKImagePickerController()
        
        pickerController.sourceType = .photo
        pickerController.assetType = .allPhotos
        pickerController.maxSelectableCount = maxCount
        pickerController.didSelectAssets = { photos in
            guard !photos.isEmpty
            else { return }
            completionHandler(photos.compactMap({ $0.originalAsset }))
        }
        
        rootVC?.present(pickerController, animated: true)
    }
}
