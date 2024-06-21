import Foundation

final class ProductLocalRepository {
    private let storage: LocalStorageType
    private let uniqueId: String
    
    init(storage: LocalStorageType, uniqueId: String) {
        self.storage = storage
        self.uniqueId = uniqueId
    }
    
    private func fetchLocalList() -> Result<[Product], ErrorCase> {
        do {
            let dict = try storage.fetchInfo()
            let list = dict[uniqueId] ?? []
            return .success(list)
        } catch {
            let error = ErrorCase(type: .generic, message: "error fetchLocalList")
            return .failure(error)
        }
    }
    
    private func saveLocalList(_ list: [Product]) -> Result<[Product], ErrorCase> {
        do {
            var dict = try storage.fetchInfo()
            dict[uniqueId] = list
            try storage.persistInfo(dict)
            return .success(list)
        } catch {
            let error = ErrorCase(type: .generic, message: "error saveLocalList")
            return .failure(error)
        }
    }
    
    private func clearLocalList() -> Result<[Product], ErrorCase> {
        do {
            var dict = try storage.fetchInfo()
            dict[uniqueId] = nil
            
            if dict.keys.isEmpty {
                storage.clearInfo()
            } else {
                try storage.persistInfo(dict)
            }
            
            return .success([])
        } catch {
            let error = ErrorCase(type: .generic, message: "error clearLocalList")
            return .failure(error)
        }
    }
}

extension ProductLocalRepository: ProductLocalRepositoryType {
    func fetchList() -> Result<[Product], ErrorCase> {
        return fetchLocalList()
    }
    
    func saveList(list: [Product]) -> Result<[Product], ErrorCase> {
        if list.isEmpty {
            return clearLocalList()
        }
        
        return saveLocalList(list)
    }
    
    func resetLists() {
        storage.clearInfo()
    }
}
