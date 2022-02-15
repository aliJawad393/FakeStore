
import Foundation
protocol URLRequestConvertable {
    func toURLRequest(baseURL: URL) -> URLRequest?
}
