import Foundation

@testable import UserDefaultsTechniques

extension Product {
    static func stub(name: String = "Produto 1") -> Product {
        Product(name: name)
    }
}

extension Array where Element == Product {
    static func stub() -> [Product] {
        [
            .stub(),
            .stub(name: "Produto 2")
        ]
    }
}
