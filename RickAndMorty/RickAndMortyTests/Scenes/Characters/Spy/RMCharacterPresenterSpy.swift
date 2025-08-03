//
//  RMCharacterPresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation

@testable import RickAndMorty

final class RMCharacterPresenterSpy: RMCharacterPresenterProtocol {
    
    private(set) var viewDidLoadCalled = false
    private(set) var getNumberOfItemsCalled = false
    private(set) var createRMCharacterTableViewCellViewModelParam = 5
    private(set) var createRMCharacterTableViewCellViewModelCalled = false
    private(set) var didSelectItemCalled = false
    private(set) var didSelectItemParam = 5
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func getNumberOfItems() -> Int {
        getNumberOfItemsCalled = true
        return 5
    }
    
    func createRMCharacterTableViewCellViewModel(at index: Int) -> RMCharacterTableViewCellViewModel {
        createRMCharacterTableViewCellViewModelCalled = true
        createRMCharacterTableViewCellViewModelParam = index
        return RMCharacterTableViewCellViewModel(title: "Mockable")
    }
    
    func didSelectItem(at index: Int) {
        didSelectItemCalled = true
        didSelectItemParam = index
    }
}
