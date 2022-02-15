import Foundation

final public class CancellableDataTask: Cancellable {
    var task: URLSessionDataTask
    
    public init(task: URLSessionDataTask) {
        self.task = task
    }
    
    public func cancelRequest() {
        self.task.cancel()
    }
}
