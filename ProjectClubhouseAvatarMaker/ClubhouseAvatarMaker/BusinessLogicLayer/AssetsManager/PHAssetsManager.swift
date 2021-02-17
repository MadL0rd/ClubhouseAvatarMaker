//
//  HPAssetsManager.swift
//  Uapp
//
//  Created by Антон Текутов on 22.10.2020.
//

import UIKit
import PhotosUI

@available(iOS 14, *)
class PHAssetsManager: AssetsManagerProtocol {
    
    private var picker: PHPickerViewController!
    private var completionHandlerSingle: ((_: ImageAssetProtocol) -> Void)?
    private var completionHandlerArray: ((_: [ImageAssetProtocol]) -> Void)?

    var rootVC: UIViewController? {
        UIApplication.shared.keyWindow?.rootViewController
    }
    
    func getSinglePhoto(_ completionHandler: @escaping ( _ photo: ImageAssetProtocol) -> Void) {
        
        completionHandlerSingle = completionHandler
        
        var configuration = PHPickerConfiguration()
        
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        rootVC?.present(picker, animated: true)
    }
    
    func getPhotosArray(maxCount: Int, completionHandler: @escaping (_ photos: [ImageAssetProtocol]) -> Void) {
        
        completionHandlerArray = completionHandler
        
        var configuration = PHPickerConfiguration()
        
        configuration.filter = .images
        configuration.selectionLimit = maxCount
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        rootVC?.present(picker, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate

@available(iOS 14, *)
extension PHAssetsManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        guard !results.isEmpty
        else { return }
        
        completionHandlerSingle?(results[0])
        completionHandlerArray?(results)
        completionHandlerSingle = nil
        completionHandlerArray = nil
    }
}
