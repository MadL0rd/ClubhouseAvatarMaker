//
//  KeychainStorageError.swift
//  Finassist
//
//  Created by Denis Severinov on 22.06.2020.
//  Copyright © 2020 Storytelling Software. All rights reserved.
//

import Foundation

enum KeychainStorageError: Error {
    case itemNotFound
    case failedToSetValue
    case failedToUpdateValue
    case failedToDeleteValue
    case failedToConvertToData
}
