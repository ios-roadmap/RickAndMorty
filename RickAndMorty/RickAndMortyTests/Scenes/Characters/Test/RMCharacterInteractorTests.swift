//
//  RMCharacterInteractorTests.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import XCTest
@testable import RickAndMorty

final class RMCharacterInteractorTests: XCTestCase {
    
    private var sut: RMCharacterInteractor!
    private var mockService: RMService!
    private var outputSpy: RMCharacterInteractorOutputSpy!
    
    override func setUp() {
        super.setUp()
        outputSpy = RMCharacterInteractorOutputSpy()
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        outputSpy = nil
        super.tearDown()
    }
    
    func test_fetchCharacters_success_shouldCallDidFetchCharacters() {
        mockService = ServiceProvider(kind: .mock)
        sut = RMCharacterInteractor(service: mockService)
        sut.presenter = outputSpy
        
        let expectation = expectation(description: "didFetchCharacters called")
        
        sut.fetchCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self, self.outputSpy.didFetchCharactersCalled else { return }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(outputSpy.didFetchCharactersCalled)
        XCTAssertEqual(outputSpy.didFetchCharactersParam?.results?.count, 1)
    }
    
    func test_fetchCharacters_failure_shouldCallDidFailWithError() {
        mockService = ServiceProvider(kind: .failure(.decodingFailed))
        sut = RMCharacterInteractor(service: mockService)
        sut.presenter = outputSpy
        
        let expectation = expectation(description: "didFailWithError called")
        
        sut.fetchCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self, self.outputSpy.didFailWithErrorCalled else { return }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(outputSpy.didFailWithErrorCalled)
        XCTAssertEqual(outputSpy.didFailWithErrorParam, .decodingFailed)
    }
}
