import Foundation

struct UserDefaultsStorage {
    private let userDefaults: UserDefaults
    private let productKey = "PRODUCT" // definar a chave por contexto de uso, depois preciso ver alguma forma de deixar essa key dinamica... pois agora esta chumbada ao contexto. Uma ideia seria cada local reposytory passar a sua key
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // Essas funcoes recebem um Product, no futuro tentar deixar dinamico usando um tipo generic
    private func encodeDictionary(list: [String: [Product]]) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(list)
    }
    
    private func decodeDictionary(data: Data) throws -> [String: [Product]] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([String: [Product]].self, from: data)
    }
}
 
extension UserDefaultsStorage: LocalStorageType {
    func persistInfo(_ info: [String : [Product]]) throws {
        let dictData = try encodeDictionary(list: info)
        userDefaults.set(dictData, forKey: productKey)
    }
    
    func fetchInfo() throws -> [String : [Product]] {
        guard let storedData = userDefaults.data(forKey: productKey) else {
            return [:]
        }

        return try decodeDictionary(data: storedData)
    }
    
    func clearInfo() {
        userDefaults.removeObject(forKey: productKey)
    }
}
