//
//  RMCharacterViewControllerTest.swift
//  RickAndMortyTests
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import XCTest
@testable import RickAndMorty

final class RMCharacterViewControllerTests: XCTestCase {
    var sut: RMCharacterViewController!
    var presenterSpy: RMCharacterPresenterSpy!

    override func setUp() {
        super.setUp()
        sut = RMCharacterViewController()
        presenterSpy = RMCharacterPresenterSpy()
        sut.presenter = presenterSpy
        sut.loadViewIfNeeded() // viewDidLoad çağrılır
    }

    override func tearDown() {
        sut = nil
        presenterSpy = nil
        super.tearDown()
    }

    func test_viewDidLoad_callsPresenterViewDidLoad() {
        XCTAssertTrue(presenterSpy.viewDidLoadCalled)
    }

    func test_numberOfRowsInSection_asksPresenterAndReturnsItsValue() {
        let rows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        XCTAssertTrue(presenterSpy.getNumberOfItemsCalled)
        XCTAssertEqual(rows, 5)
    }

    func test_cellForRowAt_usesPresenterToBuildViewModel_and_configuresCell() {
        // Spy hücreyi register et
        sut.tableView.register(RMCharacterTableViewCell.self, forCellReuseIdentifier: RMCharacterTableViewCell.identifier)

        let targetRow = 3
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: targetRow, section: 0))

        XCTAssertTrue(presenterSpy.createRMCharacterTableViewCellViewModelCalled)
        XCTAssertEqual(presenterSpy.createRMCharacterTableViewCellViewModelParam, targetRow)

        guard let spyCell = cell as? RMCharacterTableViewCell else {
            XCTFail()
            return
        }

        XCTAssertEqual(spyCell.titleLabel.text, "Mockable")
    }

    func test_didSelectRowAt_forwardsToPresenter() {
        let selectedRow = 2
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: selectedRow, section: 0))
        XCTAssertTrue(presenterSpy.didSelectItemCalled)
        XCTAssertEqual(presenterSpy.didSelectItemParam, selectedRow)
    }
}
