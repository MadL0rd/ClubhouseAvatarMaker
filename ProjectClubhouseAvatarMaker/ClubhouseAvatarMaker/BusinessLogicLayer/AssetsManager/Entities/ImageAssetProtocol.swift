//
//  ImageAssetProtocol.swift
//  Uapp
//
//  Created by Антон Текутов on 22.10.2020.
//

import UIKit

protocol ImageAssetProtocol {
    
    //targetSize: CGSize, setImageHandler: (_: UIImage) -> Void
    var loadImageForTargetSize: ((_ targetSize: CGSize, _ setImageHandler: @escaping GetImageFromAssetCompletion) -> Void)? { get }
    
    func loadOriginalImage(_ setImageHandler: @escaping GetImageFromAssetCompletion)
}

extension ImageAssetProtocol {
    
    func tryToLoadImageWithTargetSizeThenLoadOriginal(targetSize: CGSize, setImageHandler: @escaping GetImageFromAssetCompletion) {
        if let load = loadImageForTargetSize {
            load(targetSize, setImageHandler)
        } else {
            loadOriginalImage(setImageHandler)
        }
    }
}
