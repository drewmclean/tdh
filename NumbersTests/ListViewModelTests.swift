//
//  NumbersTests.swift
//  NumbersTests
//
//  Created by Andrew McLean on 5/11/22.
//

import XCTest
@testable import Numbers

class ListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testGetNumbersHappyPath() throws {
        let viewModel = ListViewModel(numbersClient: .mockHappy)
        
        let expectation = self.expectation(description: "ListViewModel.happyPath")
        
        var didInitialize: Bool = false
        var didEnterFetching: Bool = false
        
        viewModel.viewState.bind { state in
            switch state {
            case .initializing:
                didInitialize = true
            case .fetching:
                didEnterFetching = true
            case .fetchComplete:
                XCTAssertEqual(viewModel.items.count, 3)
                XCTAssertTrue(didInitialize)
                XCTAssertTrue(didEnterFetching)
                expectation.fulfill()
            case .fetchError(let e):
                XCTFail(e)
            }
        }
        
        viewModel.reloadData()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetWeatherFailureNetworkError() throws {
        let viewModel = ListViewModel(numbersClient: .mockFail)
        
        let failed = self.expectation(description: "ListViewModel.networkError")
        let initialized = self.expectation(description: "ListViewModel.initialized")
        let loading = self.expectation(description: "ListViewModel.networkError")
        
        viewModel.viewState.bind { state in
            switch state {
            case .initializing:
                initialized.fulfill()
            case .fetching:
                loading.fulfill()
            case .fetchComplete:
                XCTFail()
                failed.fulfill()
            case .fetchError(let message):
                XCTAssertNotNil(message)
                failed.fulfill()
            }
        }
        
        viewModel.reloadData()
        waitForExpectations(timeout: 2, handler: nil)
    }

}

