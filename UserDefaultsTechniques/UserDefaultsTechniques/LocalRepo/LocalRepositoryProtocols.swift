import Foundation

protocol ProductLocalRepositoryType {
    func fetchList() -> Result<[Product], ErrorCase>
    func saveList(list: [Product]) -> Result<[Product], ErrorCase>
    func resetLists()
}

protocol LocalStorageType {
    func persistInfo(_ info: [String: [Product]]) throws
    func fetchInfo() throws -> [String: [Product]]
    func clearInfo()
}
