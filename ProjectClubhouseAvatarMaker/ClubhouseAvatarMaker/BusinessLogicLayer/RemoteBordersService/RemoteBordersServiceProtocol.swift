//
//  RemoteBordersServiceProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Foundation

protocol RemoteBordersServiceProtocol: class {
    
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion)
}
