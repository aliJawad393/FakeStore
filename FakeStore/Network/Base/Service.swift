
import Foundation

class Service {
    private let session: URLSession
    private let baseURL: URL
    let parser: Parser
    
    //MARK: Init
    public init(session: URLSession, baseURL: URL, parser: Parser) {
        self.baseURL = baseURL
        self.session = session
        self.parser = parser
    }
    private init() {
        fatalError("Can't be initialized without required parameters")
    }
    
    func performRequest(request: URLRequestConvertable, completion: @escaping (Result<(Data, HTTPURLResponse?), Error>) -> Void) -> Cancellable? {
        guard let urlRequest = request.toURLRequest(baseURL: baseURL) else {
            completion(.failure(NetworkError.urlCreationFailed))
            return nil
        }
        
        let task: URLSessionDataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data, let response = response {
                let returnValue = (data, response as? HTTPURLResponse)
                completion(.success(returnValue))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        return CancellableDataTask(task: task)
        
    }
}
