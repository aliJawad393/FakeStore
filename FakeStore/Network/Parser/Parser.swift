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
