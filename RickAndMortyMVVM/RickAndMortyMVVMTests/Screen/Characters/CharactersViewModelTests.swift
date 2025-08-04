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
        sut = CharactersViewModel(viewController: viewController)
        print("setup trigger")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
