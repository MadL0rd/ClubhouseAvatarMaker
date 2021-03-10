//
//  BordersActualityManager.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 10.03.2021.
//

import Foundation

@objc protocol BordersActualityManagerSubscriber: class {
    
    func needToReloadBorders()
}

protocol BordersActualityManagerProtocol: class {
    
    func subscribe(_ subscriber: BordersActualityManagerSubscriber)
    func needToReloadBorders()
}

class BordersActualityManager: BordersActualityManagerProtocol {
        
    static let shared: BordersActualityManagerProtocol = BordersActualityManager()
    
    var subscribers = [Weak<BordersActualityManagerSubscriber>]()
    
    func subscribe(_ subscriber: BordersActualityManagerSubscriber) {
        subscribers.reap()
        subscribers.append(Weak(value: subscriber))
    }
    
    func needToReloadBorders() {
        subscribers.reap()
        for subscriber in subscribers {
            subscriber.value?.needToReloadBorders()
        }
    }
}

extension Array where Element: Weak<BordersActualityManagerSubscriber> {
    
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
