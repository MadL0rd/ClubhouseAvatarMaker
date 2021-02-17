//
//  AppRouter.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

protocol AppRouter: class {

	var window: UIWindow! { get set }
    
    func handleLaunch()
}
