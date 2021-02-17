//
//  PHPickerResult+ImageAssetProtocol.swift
//  Uapp
//
//  Created by Антон Текутов on 22.10.2020.
//

import PhotosUI
import UIKit

@available(iOS 14, *)
extension PHPickerResult: ImageAssetProtocol {
    
    var loadImageForTargetSize: ((_ targetSize: CGSize, _ setImageHandler: @escaping GetImageFromAssetCompletion) -> Void)? {
        return nil
    }
    
    func loadOriginalImage(_ setImageHandler: @escaping GetImageFromAssetCompletion) {
        let provider = itemProvider
        guard provider.canLoadObject(ofClass: UIImage.self)
        else {
            setImageHandler(.failure(.assetIsNotImage))
            return
        }
        provider.loadObject(ofClass: UIImage.self) { (image, error) in
            if let error = error {
                print(error)
            }
            if let image = image as? UIImage {
                setImageHandler(.success(image))
            }
        }
        
    }
}
