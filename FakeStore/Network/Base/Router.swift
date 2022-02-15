
import Foundation

protocol Router: URLRequestConvertable {
    var method: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? {get}
}

extension Router {
    func toURLRequest(baseURL: URL) -> URLRequest? {
        var url = baseURL.appendingPathComponent(path)
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = parameters
            url = components.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
