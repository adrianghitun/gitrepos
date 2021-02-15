//
//  RepositoriesViewModelTests.swift
//  GitHubReposTests
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import XCTest
@testable import GitHubRepos

class RepositoriesViewModelTests: XCTestCase {
    var viewModel: RepositoriesViewModel?

    override func setUp() {
        let mockedRepoService = MockedRepositoryService()
        let mockedImageDownloader = MockedImageDownloader()
        viewModel = RepositoriesViewModel(service: RepositoriesService(service: mockedRepoService),
                                          imageProvider: mockedImageDownloader)
        viewModel?.loadRepositories()
        
        let exp = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }

    func testNumberOfItems() {
        XCTAssertEqual(viewModel!.numberOfSections, 1)
    }

    func testFirstItemDescription() {
        XCTAssertEqual(viewModel!.item(at: IndexPath(row: 0, section: 0)).content, "description3")
    }

    func testDelegateCallbacks() {
        let delegate = RepositoriesLoadDelegate()
        viewModel?.dataStateBinding = delegate


        viewModel?.loadRepositories()
        XCTAssertEqual(delegate.state, .loading)
        
        let exp = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
        
        XCTAssertEqual(delegate.state, .loaded)
    }
}

class RepositoriesLoadDelegate: DataStateBindingProtocol {
    var state: DataState?
    
    func dataStateDidChanged(_ state: DataState) {
        self.state = state
    }
}

class MockedRepositoryService: BaseServiceProtocol {
    let dummyRepos = [
        Repository(name: "name1", description: "description1", stars: 1, owner: Owner(login: "name1", avatarPath: "avatar")),
        Repository(name: "name2", description: "description2", stars: 2, owner: Owner(login: "name2", avatarPath: "avatar")),
        Repository(name: "name3", description: "description3", stars: 3, owner: Owner(login: "name3", avatarPath: "avatar")),
    ]

    func get<T: Decodable>(baseUrl: URL?, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        guard let response = QueryResult<Repository>(items: dummyRepos) as? T else {
            assertionFailure("invalid mock")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(Result.success(response))
        }
    }
}

class MockedImageDownloader: RepositoryImageProviderProtocol {
    func image(for repository: Repository, completion: @escaping (Any?) -> Void) {
        completion(nil)
    }
}
