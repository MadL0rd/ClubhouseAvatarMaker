//
//  DataRequestExecutable.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

protocol DataRequestExecutable {
    
    var execute: DataRequest { get }
}
