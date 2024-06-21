import Foundation

@testable import UserDefaultsTechniques

extension ErrorCase {
    static func stub(type: ErrorType = .generic,
                     message: String = "") -> ErrorCase {
        ErrorCase(type: type,
                  message: message)
    }
}
