//
//  DataParser.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import Foundation

class DataParser {
    
    static func parse<T: Codable>(data: Data) -> T? {
        do {
            let parcedData = try JSONDecoder().decode(T.self, from: data)
            return (parcedData)
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil
    }
}
