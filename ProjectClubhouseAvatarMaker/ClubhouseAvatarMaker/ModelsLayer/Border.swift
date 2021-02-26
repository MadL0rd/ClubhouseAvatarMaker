//
//  Border.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

struct Border: BorderProtocol {
    
    let image: UIImage?
    let colorable: Bool
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case colorable = "colorable"
        case imageUrl = "image"
        case image = "kek"
    }
    
    init(colorable: Bool, image: UIImage? = nil, title: String? = nil) {
        self.image = image
        self.colorable = colorable
        self.title = title
    }
    
    func setToImageView(_ imageView: UIImageView) {
        imageView.image = image?.withRenderingMode(colorable ? .alwaysTemplate : .alwaysOriginal)
    }
}
