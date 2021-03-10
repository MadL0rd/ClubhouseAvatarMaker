//
//  CustomArrayEncoding.swift
//  Uapp
//
//  Created by Антон Текутов on 09.11.2020.
//

import Alamofire

struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]

    init(array: [Parameters]) {
        self.array = array
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        let data = try JSONSerialization.data(withJSONObject: array, options: [])

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpBody = data

        return urlRequest
    }
}
