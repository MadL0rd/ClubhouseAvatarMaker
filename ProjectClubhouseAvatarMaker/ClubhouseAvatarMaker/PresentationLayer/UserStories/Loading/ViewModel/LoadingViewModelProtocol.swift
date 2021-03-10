//
//  LoadingViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import Foundation

protocol LoadingViewModelProtocol: class {
    
    func startConfiguration()
    func checkUpdateIsAvailable(callback: @escaping AppStoreInfoCompletion)
}
