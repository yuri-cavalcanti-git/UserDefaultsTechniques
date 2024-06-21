import Foundation

struct ErrorCase: Error {
    let type: ErrorType
    let message: String
    
    enum ErrorType {
        case generic
    }
}
