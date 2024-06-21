import Foundation
import Quick
import Nimble

@testable import UserDefaultsTechniques

final class UserDefaultsStorageTests: QuickSpec {
    override func spec() {
        let key = "PRODUCT"
        var sut: UserDefaultsStorage!
        var userDefault: UserDefaults!
        
        beforeEach {
            userDefault = UserDefaults()
            userDefault.removeObject(forKey: key)
            sut = UserDefaultsStorage(userDefaults: userDefault)
        }
        
        describe("#persistInfo") {
            beforeEach {
                try? sut.persistInfo([key: .stub()])
            }
            
            it("persist data with correct key") {
                let products: [Product] = .stub()
                let dictData = try self.encodeDictionary(list: [key : products])
                expect(userDefault.data(forKey: key)) == dictData
            }
        }
        
        describe("fetchData") {
            context("fetch success") {
                beforeEach {
                    let data = Data("data".utf8)
                    userDefault.set(data, forKey: key)
                }
                it ("Tentar fazer este teste") {
                    let dict = try? sut.fetchInfo()
//                    expect(dict) == ["": .stub()]
                }
            }
        }
        
        describe("#clearInfo") {
            beforeEach {
                let data = Data("data".utf8)
                userDefault.set(data, forKey: key)
                try? sut.clearInfo()
            }
            
            it("clear user default data for correct key") {
                let localData = userDefault.data(forKey: key)
                expect(localData) == nil
            }
        }
    }
    
    private func encodeDictionary(list: [String: [Product]]) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(list)
    }
}
