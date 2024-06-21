import UIKit

class ViewController: UIViewController {
    private var products: [Product] {
        return [
            Product(name: "produto 1"),
            Product(name: "produto 2")
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // num caso real fazer isso no coordinator e injetar num presenter
        let storage = UserDefaultsStorage()
        let productRepository = ProductLocalRepository(storage: storage,
                                                       uniqueId: "1")
        
        // No presenter chamar as funcoes
        saveList(repository: productRepository)
        
        fetchList(repository: productRepository)
        
    }
    
    private func saveList(repository: ProductLocalRepository) {
        let savedProductList = repository.saveList(list: products)
        
        switch savedProductList {
        case .success(let list):
            print(list)
        case .failure(let error):
            print(error.message)
        }
    }
    
    private func fetchList(repository: ProductLocalRepository) {
        switch repository.fetchList() {
        case .success(let list):
            print(list)
        case .failure(let error):
            print(error.message)
            repository.resetLists()
        }
    }
}

