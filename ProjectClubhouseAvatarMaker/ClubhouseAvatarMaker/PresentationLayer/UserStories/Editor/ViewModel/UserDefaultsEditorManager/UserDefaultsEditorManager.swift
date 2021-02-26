//
//  UserDefaultsEditorManager.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import Foundation
import UIKit

fileprivate enum Keys: String {
    case emoji
    case avatarEmojiCenterX
    case avatarEmojiCenterY
    case showNewUserIcon
    case showMuteIcon
    case addEmoji
    case selectedBorderColor
    case isNotFirstLaunch
}

class UserDefaultsEditorManager: UserDefaultsEditorManagerProtocol {
    
    private let defaults = UserDefaults.standard
    
    var emoji: String {
        get {
            defaults.string(forKey: Keys.emoji.rawValue) ?? "🔥"
        }
        set {
            defaults.set(newValue, forKey: Keys.emoji.rawValue)
        }
    }
    
    var avatarEmojiCenterX: Float {
        get {
            defaults.float(forKey: Keys.avatarEmojiCenterX.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.avatarEmojiCenterX.rawValue)
        }
    }
    
    var avatarEmojiCenterY: Float {
        get {
            defaults.float(forKey: Keys.avatarEmojiCenterY.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.avatarEmojiCenterY.rawValue)
        }
    }
    
    var showNewUserIcon: Bool {
        get {
            defaults.bool(forKey: Keys.showNewUserIcon.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.showNewUserIcon.rawValue)
        }
    }
    
    var showMuteIcon: Bool {
        get {
            defaults.bool(forKey: Keys.showMuteIcon.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.showMuteIcon.rawValue)
        }
    }
    
    var addEmoji: Bool {
        get {
            defaults.bool(forKey: Keys.addEmoji.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.addEmoji.rawValue)
        }
    }
    
    var selectedBorderColor: UIColor? {
        get {
            defaults.color(forKey: Keys.selectedBorderColor.rawValue) ?? R.color.backgroundDark()
        }
        set {
            defaults.set(newValue, forKey: Keys.selectedBorderColor.rawValue)
        }
    }
    
    var isNotFirstLaunch: Bool {
        get {
            defaults.bool(forKey: Keys.isNotFirstLaunch.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.isNotFirstLaunch.rawValue)
        }
    }
    
    init() {
        if !isNotFirstLaunch {
            showNewUserIcon = true
            showMuteIcon = true
            addEmoji = true
            isNotFirstLaunch = true
        }
    }
}
