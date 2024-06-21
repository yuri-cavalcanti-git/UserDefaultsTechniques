import Foundation

struct ErrorCase: Error, Equatable {
    let type: ErrorType
    let message: String
    
    enum ErrorType {
        case generic
    }
}
