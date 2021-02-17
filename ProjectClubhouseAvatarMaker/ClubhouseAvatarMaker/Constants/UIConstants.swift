//
//  UIConstants.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

struct UIConstants {

    static let statusBarHeight: CGFloat = {
        return UIApplication.shared.statusBarFrame.size.height
    }()

    static let navigationBarHeight: CGFloat = {
        let navController = UINavigationController()
        let height = navController.navigationBar.bounds.height + statusBarHeight
        return height
    }()

    static let navigationBarCenterY: CGFloat = {
        return statusBarHeight + (UIConstants.navigationBarHeight - UIConstants.statusBarHeight) / 2
    }()
    
    static let screenBounds: CGRect = {
        return UIScreen.main.bounds
    }()
    
    static let widthDesignCoefficient: CGFloat = {
        UIConstants.screenBounds.width / 375
    }()
    
    static let heightDesignCoefficient: CGFloat = {
        UIConstants.screenBounds.height / 812
    }()
}
