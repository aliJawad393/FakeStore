//
//  Parser.swift
//  Weather Sample App
//
//  Created by Ali Jawad on 08/02/2022.
//

import Foundation

protocol Parser {
    func parseResponse<T : Decodable>(data: Data? , response: T.Type)->T?
}


final class JSONParser: Parser {
    func parseResponse<T : Decodable>(data: Data? , response: T.Type)->T? {
        guard let dateValue = data else { return  nil }
        
        let decoder = try? JSONDecoder().decode(response, from: dateValue)
        return decoder
    }
}
