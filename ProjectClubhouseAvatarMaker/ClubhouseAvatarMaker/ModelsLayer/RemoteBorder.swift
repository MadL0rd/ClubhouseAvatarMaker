//
//  RemoteBorder.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import UIKit
import SDWebImage

struct RemoteBorder: BorderProtocol, Codable {
    
    var colorable: Bool
    var title: String?
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case colorable = "colorable"
        case title = "title"
        case imageUrl = "image"
    }
    
    func setToImageView(_ imageView: UIImageView) {
        imageView.image = nil
        guard let url = URL(string: imageUrl)
        else { return }
        imageView.setDefaultLoadingInicator()
        imageView.sd_setImage(with: url)
    }
}
