import Foundation

@testable import UserDefaultsTechniques

final class LocalStorageSpy: LocalStorageType {
    private var fakeError: Error {
        ErrorCase.stub()
    }
    
    var persistInfoThrows = false
    private(set) var persistInfoCallCount = 0
    private(set) var persistInfoLastParam: [String: [Product]]?
    func persistInfo(_ info: [String : [UserDefaultsTechniques.Product]]) throws {
        persistInfoCallCount += 1
        persistInfoLastParam = info
        
        if persistInfoThrows {
            throw fakeError
        }
    }
    
    var fetchInfoThrows = false
    var fetchInfoStub: [String: [Product]] = [:]
    private(set) var fetchInfoCallCount = 0
    func fetchInfo() throws -> [String : [UserDefaultsTechniques.Product]] {
        fetchInfoCallCount += 1
        
        if fetchInfoThrows {
            throw fakeError
        } else {
            return fetchInfoStub
        }
    }
    
    private(set) var clearInfoCallCount = 0
    func clearInfo() {
        clearInfoCallCount += 1
    }
}
