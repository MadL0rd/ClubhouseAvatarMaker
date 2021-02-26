//
//  UIImageView+setDefaultLoadingInicator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func setDefaultLoadingInicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
}
