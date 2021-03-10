//
//  Array+weakObjects.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 10.03.2021.
//

import Foundation

class Weak<T: AnyObject> {
        
    weak var value: T?
    
    init (value: T) {
        self.value = value
    }
}

extension Array where Element: Weak<AnyObject> {
    
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
