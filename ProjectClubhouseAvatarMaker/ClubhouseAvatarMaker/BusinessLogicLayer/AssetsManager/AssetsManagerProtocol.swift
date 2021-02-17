//
//  AssetsManagerProtocol.swift
//  ClipGo
//
//  Created by Антон Текутов on 11.07.2020.
//

import Photos

protocol AssetsManagerProtocol {
    
    func getSinglePhoto(_ completionHandler: @escaping ( _ photo: ImageAssetProtocol) -> Void)
    func getPhotosArray(maxCount: Int, completionHandler: @escaping (_ photos: [ImageAssetProtocol]) -> Void)
}
