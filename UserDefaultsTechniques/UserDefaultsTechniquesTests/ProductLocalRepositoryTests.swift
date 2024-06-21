import Foundation
import Quick
import Nimble

@testable import UserDefaultsTechniques

final class ProductLocalRepositoryTests: QuickSpec {
    override func spec() {
        var sut: ProductLocalRepository!
        var storage: LocalStorageSpy!
        
        beforeEach {
            storage = LocalStorageSpy()
            sut = ProductLocalRepository(storage: storage, uniqueId: "unique_id")
        }
        
        describe("#fetchList") {
            context("storage fetch throws error") {
                beforeEach {
                    storage.fetchInfoThrows = true
                }
                
                it("returns error") {
                    let result = sut.fetchList()
                    
                    expect(storage.fetchInfoCallCount) == 1
                    
                    expect(result).to(beFailure { error in
                        expect(error) == .stub(message: "error fetchLocalList")
                    })
                }
            }
            
            context("storage returns empty data") {
                it("returns error") {
                    let result = sut.fetchList()
                    
                    expect(storage.fetchInfoCallCount) == 1
                    
                    expect(result).to(beSuccess { array in
                        expect(array).to(beEmpty())
                    })
                }
            }
            
            context("storage returns valid data") {
                beforeEach {
                    storage.fetchInfoStub = ["unique_id": .stub()]
                }
                
                it("returns error") {
                    let result = sut.fetchList()
                    
                    expect(storage.fetchInfoCallCount) == 1
                    
                    expect(result).to(beSuccess { array in
                        expect(array) == .stub()
                    })
                }
            }
        }
        
        describe("#saveList") {
            context("storage fetch throws error") {
                beforeEach {
                    storage.fetchInfoThrows = true
                }
                
                it("returns error") {
                    let result = sut.saveList(list: .stub())
                    
                    expect(storage.persistInfoCallCount) == 0
                    
                    expect(result).to(beFailure { error in
                        expect(error) == .stub(message: "error saveLocalList")
                    })
                }
            }
            
            context("storage persist throws error") {
                beforeEach {
                    storage.persistInfoThrows = true
                }
                
                it("returns error") {
                    let result = sut.saveList(list: .stub())
                    
                    expect(storage.persistInfoCallCount) == 1
                    expect(storage.persistInfoLastParam) == ["unique_id": .stub()]
                    
                    expect(result).to(beFailure { error in
                        expect(error) == .stub(message: "error saveLocalList")
                    })
                }
            }
            
            context("list is empty") {
                it("call clear on storage and returns empty list") {
                    let result = sut.saveList(list: [])
                    
                    expect(storage.clearInfoCallCount) == 1
                    
                    expect(result).to(beSuccess { array in
                        expect(array).to(beEmpty())
                    })
                }
            }
            
            context("save valid data") {
                it("calls store to persist and returns array") {
                    let result = sut.saveList(list: .stub())
                    
                    expect(storage.persistInfoCallCount) == 1
                    expect(storage.persistInfoLastParam) == ["unique_id": .stub()]
                    
                    expect(result).to(beSuccess { array in
                        expect(array) == .stub()
                    })
                }
            }
            
            describe("#resetList") {
                beforeEach {
                    sut.resetLists()
                }
                
                it("calls storage to clear all data") {
                    expect(storage.clearInfoCallCount) == 1
                }
            }
        }
    }
}
