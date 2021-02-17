//
//  PHAsset+ImageAssetProtocol.swift
//  Uapp
//
//  Created by Антон Текутов on 22.10.2020.
//

import Photos
import UIKit

extension PHAsset: ImageAssetProtocol {
    
    var loadImageForTargetSize: ((_ targetSize: CGSize, _ setImageHandler: @escaping GetImageFromAssetCompletion) -> Void)? {
        return { [ weak self ] targetSize, setImageHandler in
            guard let self = self
            else { return }
            self.loadImageAssetForTargetSize(targetSize: targetSize, setImageHandler: setImageHandler)
        }
    }
    
    func loadOriginalImage(_ setImageHandler: @escaping GetImageFromAssetCompletion) {
        guard mediaType == .image
        else {
            setImageHandler(.failure(.assetIsNotImage))
            return
        }
        
        let targetSize = UIScreen.main.bounds.size
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        
        PHImageManager.default()
            .requestImage(for: self,
                          targetSize: targetSize,
                          contentMode: .default,
                          options: options) { (_image: UIImage?, _) -> Void in
                guard let image = _image
                else { return }
                setImageHandler(.success(image))
            }
    }
    
    private func loadImageAssetForTargetSize(targetSize: CGSize, setImageHandler: @escaping GetImageFromAssetCompletion) {
        guard mediaType == .image
        else {
            print("Error! PHAsset \(self) is not image!")
            return
        }
        
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        PHImageManager.default()
            .requestImage(for: self,
                          targetSize: targetSize,
                          contentMode: .default,
                          options: options) { (image: UIImage?, _) -> Void in
                guard let image = image
                else {
                    setImageHandler(.failure(.unknown))
                    return
                }
                setImageHandler(.success(image))
            }
    }
}

