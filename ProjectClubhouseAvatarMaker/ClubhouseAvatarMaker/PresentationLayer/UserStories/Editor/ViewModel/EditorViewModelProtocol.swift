//
//  EditorViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

protocol EditorViewModelProtocol: class {
    
    var borders: [Border] { get }
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void)
}
