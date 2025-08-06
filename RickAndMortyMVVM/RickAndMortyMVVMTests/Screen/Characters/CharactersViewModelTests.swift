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
    private var service: MockNetworkService!
    
    override class func setUp() {
        print("Ömer Faruk Öztürk")
    }
    
    override func setUp() {
        super.setUp()
        viewController = MockCharactersViewController()
        let rmcharacters = RMCharacters(
            info: .init(count: 1, pages: 2, next: "next", prev: "prev"),
            results: [.init(
                id: 1,
                name: "name",
                status: .alive,
                species: "species",
                type: "type",
                gender: "gender",
                origin: .init(name: "name", url: "url"),
                location: .init(name: "name", url: "url"),
                image: "image",
                episode: ["episode"],
                url: "url",
                created: "created"
            )]
        )
        service = MockNetworkService(response: rmcharacters)
        sut = CharactersViewModel(viewController: viewController, service: service)
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
        XCTAssertEqual(sut.numberOfItems(), 1)
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
        XCTAssertEqual(sut.characterInfo?.pages, 42)
    }
}
