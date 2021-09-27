//
//  LoadingViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import Foundation

protocol LoadingViewModelProtocol: AnyObject {
    
    func checkUpdateIsAvailable(completion: @escaping AppStoreInfoCompletion)
    func configureRemoteBordersAccount(completion: @escaping() -> Void)
}
