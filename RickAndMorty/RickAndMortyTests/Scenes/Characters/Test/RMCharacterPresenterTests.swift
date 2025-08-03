//
//  RMCharacterPresenterTests.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import XCTest
@testable import RickAndMorty

final class RMCharacterPresenterTests: XCTestCase {

    private var sut: RMCharacterPresenter!
    private var interactorSpy: RMCharacterInteractorSpy!
    private var viewSpy: RMCharacterViewControllerSpy!
    private var routerSpy: RMCharacterRouterSpy!

    override func setUp() {
        super.setUp()
        interactorSpy = RMCharacterInteractorSpy()
        viewSpy = RMCharacterViewControllerSpy()
        routerSpy = RMCharacterRouterSpy()

        sut = RMCharacterPresenter()
        sut.interactor = interactorSpy
        sut.viewController = viewSpy
        sut.router = routerSpy
    }

    override func tearDown() {
        sut = nil
        interactorSpy = nil
        viewSpy = nil
        routerSpy = nil
        super.tearDown()
    }

    func test_viewDidLoad_shouldShowLoadingAndCallFetchCharacters() {
        sut.viewDidLoad()

        XCTAssertTrue(viewSpy.showLoadingCalled)
        XCTAssertTrue(interactorSpy.fetchCharactersCalled)
    }

    func test_didFetchCharacters_shouldHideLoadingAndReloadData() {
        let character = RMCharacter(
            id: 1,
            name: "Rick",
            status: nil,
            species: nil,
            type: nil,
            gender: nil,
            origin: nil,
            location: nil,
            image: nil,
            episode: nil,
            url: nil,
            created: nil
        )
        let characters = RMCharacters(info: nil, results: [character])

        sut.didFetchCharacters(characters)

        XCTAssertTrue(viewSpy.hideLoadingCalled)
        XCTAssertTrue(viewSpy.reloadDataCalled)
        XCTAssertEqual(sut.getNumberOfItems(), 1)
    }

    func test_didFailWithError_shouldHideLoadingAndShowError() {
        let error = APIError.decodingFailed

        sut.didFailWithError(error)

        XCTAssertTrue(viewSpy.hideLoadingCalled)
        XCTAssertTrue(viewSpy.showErrorCalled)
        XCTAssertEqual(viewSpy.showErrorParam, error.localizedDescription)
    }

    func test_createRMCharacterTableViewCellViewModel_shouldReturnCorrectModel() {
        let character = RMCharacter(id: 1, name: "Morty", status: nil, species: nil, type: nil, gender: nil, origin: nil, location: nil, image: nil, episode: nil, url: nil, created: nil)
        sut.didFetchCharacters(RMCharacters(info: nil, results: [character]))

        let viewModel = sut.createRMCharacterTableViewCellViewModel(at: 0)
        XCTAssertEqual(viewModel.title, "Morty")
    }

    func test_didSelectItem_shouldNavigateToDetail() {
        let character = RMCharacter(id: 1, name: "Summer", status: nil, species: nil, type: nil, gender: nil, origin: nil, location: nil, image: nil, episode: nil, url: nil, created: nil)
        sut.didFetchCharacters(RMCharacters(info: nil, results: [character]))

        sut.didSelectItem(at: 0)

        XCTAssertTrue(routerSpy.navigateToDetailCalled)
        XCTAssertEqual(routerSpy.navigateToDetailParam?.name, "Summer")
    }
}
