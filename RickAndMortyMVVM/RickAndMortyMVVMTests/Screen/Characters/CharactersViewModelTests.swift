//
//  CharactersViewModelTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import XCTest
@testable import RickAndMortyMVVM

@MainActor
final class CharactersViewModelTests: XCTestCase {
    
    private var sut: CharactersViewModel!
    private var viewController: MockCharactersViewController!
    
    override class func setUp() {
        print("Ömer Faruk Öztürk")
    }
    
    override func setUp() {
        super.setUp()
        viewController = MockCharactersViewController()
        sut = CharactersViewModel(
            viewController: viewController,
            service: MockRMService()
        )
        print("setup trigger")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_viewDidLoad_ShouldBeSetViewDidLoad() {
        Task {
            await sut.viewDidLoad()
            try? await Task.sleep(nanoseconds: 100_000_000)
            
            XCTAssertTrue(viewController.prepareCollectionViewCalled)
            XCTAssertTrue(viewController.setBackgroundColorCalled)
            XCTAssertEqual(viewController.setBackgroundColorParam, .systemBackground)
            XCTAssertTrue(viewController.preFetchCalled)
            XCTAssertTrue(viewController.fetchLoadedCalled)
        }
    }
    
    func test_numberOfItms_ShouldBeSetCount() async {
        await sut.viewDidLoad()
        XCTAssertEqual(sut.numberOfItems(), 0)
    }
    
    func test_configureCellAtIndex_ShouldBeSetCharacter() async {
        await sut.viewDidLoad()
        sut.configure(cell: .init(), at: 0)
    }
    
    func test_willDisplayItemAtIndex_ShouldBeFetchNextPage() async {
        await sut.viewDidLoad()
        
        sut.willDisplayItem(at: 19)
        XCTAssertEqual(sut.characters.count, 0)
        XCTAssertEqual(sut.page, 1)
        XCTAssertEqual(sut.characterInfo?.pages, 3)
    }
    
    func test_DidFailedFetch_ShouldBeShowAlert() async {
        let expectation = XCTestExpectation(description: "Fetch should fail and alert should be shown")

        viewController = MockCharactersViewController()
        viewController.onShowAlert = {
            expectation.fulfill()
        }

        sut = CharactersViewModel(
            viewController: viewController,
            service: ErrorRMService()
        )

        await sut.viewDidLoad()

        // Burada async işlemlerin tamamlanmasını bekliyoruz
        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertTrue(viewController.showAlertCalled)
        XCTAssertTrue(viewController.preFetchCalled)
        XCTAssertTrue(viewController.fetchFailedCalled)
        XCTAssertEqual(viewController.fetchFailedParam, "The operation couldn’t be completed. (RickAndMortyMVVM.NetworkError error 0.)")
    }

}
