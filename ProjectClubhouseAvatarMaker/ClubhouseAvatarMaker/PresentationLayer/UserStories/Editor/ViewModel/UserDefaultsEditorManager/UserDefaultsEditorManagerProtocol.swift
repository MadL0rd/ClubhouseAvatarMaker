//
//  UserDefaultsEditorManagerProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import UIKit

protocol UserDefaultsEditorManagerProtocol: AnyObject {
    
    var emoji: String { get set }
    var avatarEmojiCenterX: Float { get set }
    var avatarEmojiCenterY: Float { get set }
    var showNewUserIcon: Bool { get set }
    var showMuteIcon: Bool { get set }
    var addEmoji: Bool { get set }
    var selectedBorderColor: UIColor? { get set }
}
