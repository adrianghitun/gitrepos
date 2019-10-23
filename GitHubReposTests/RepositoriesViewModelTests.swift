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
        viewModel = RepositoriesViewModel(service: RepositoriesService(service: mockedRepoService), imageDownloader: mockedImageDownloader)
        viewModel?.loadRepositories()
    }

    func testNumberOfItems() {
        XCTAssertEqual(viewModel!.numberOfItems, 3)
    }

    func testFirstItemDescription() {
        XCTAssertEqual(viewModel!.item(for: 0).description, "description1")
    }

    func testDelegateCallbacks() {
        let delegate = RepositoriesLoadDelegate()
        viewModel?.delegate = delegate

        XCTAssertEqual(delegate.didFinish, false)
        XCTAssertEqual(delegate.didUpdate, false)

        viewModel?.loadRepositories()

        XCTAssertEqual(delegate.didFinish, true)
        XCTAssertEqual(delegate.didUpdate, true)
    }
}

class RepositoriesLoadDelegate: RepositoriesViewModelDelegate {
    var didFinish = false
    func didFinishLoading() {
        didFinish = true
    }

    var didUpdate = false
    func didUpdateDatasource() {
        didUpdate = true
    }
}

class MockedRepositoryService: BaseServiceProtocol {
    let dummyRepos = [
        Repository(name: "name1", description: "description1", stars: 1, owner: Owner(login: "name1", avatarPath: "avatar")),
        Repository(name: "name2", description: "description2", stars: 2, owner: Owner(login: "name2", avatarPath: "avatar")),
        Repository(name: "name3", description: "description3", stars: 3, owner: Owner(login: "name3", avatarPath: "avatar")),
    ]

    func get<T: Decodable>(baseUrl: URL?, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        guard let response = RepositoryQuery(items: dummyRepos) as? T else {
            assertionFailure("invalid mock")
            return
        }
        completion(Result.success(response))
    }
}

class MockedImageDownloader: ImageDownloaderProtocol {
    func image(for url: URL, completion: @escaping (Any?) -> Void) {
        completion(nil)
    }
}
