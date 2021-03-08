//
//  SettingsStoring.swift
//  Finassist
//
//  Created by Denis Severinov on 22.06.2020.
//  Copyright © 2020 Storytelling Software. All rights reserved.
//

import Foundation

protocol SettingsStoring {
    func set(_ itemValue: Bool, for itemKey: StorageItemKey) throws
    func set(_ itemValue: String, for itemKey: StorageItemKey) throws

    func getBoolValue(for itemKey: StorageItemKey) -> Bool?
    func getStringValue(for itemKey: StorageItemKey) -> String?

    func deleteValue(for itemKey: StorageItemKey) throws
}
