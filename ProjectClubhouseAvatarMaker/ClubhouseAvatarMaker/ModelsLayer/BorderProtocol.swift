//
//  BorderProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import UIKit

protocol BorderProtocol {
    
    var colorable: Bool { get }
    var title: String? { get }
    
    func setToImageView(_ imageView: UIImageView)
}
