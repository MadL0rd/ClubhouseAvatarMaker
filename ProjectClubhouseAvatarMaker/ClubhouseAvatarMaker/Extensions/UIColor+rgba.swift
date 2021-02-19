//
//  UIColor+rgba.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

struct ColorComponents {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
}

extension UIColor {
    var rgba: ColorComponents {
        var components = ColorComponents()
        getRed(&components.red,
               green: &components.green,
               blue: &components.blue,
               alpha: &components.alpha)

        return components
    }
}
