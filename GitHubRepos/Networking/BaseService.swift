//
//  BaseService.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import Alamofire

/*
 Exposing only what matters. Hiding the actual implementation.
 Depending upon abstractions not concretions
 */
protocol BaseServiceProtocol {
    func get<T: Decodable>(baseUrl: URL?, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void))
    func post<T: Decodable>(baseUrl: URL?, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void))
}

/*
 Giving the ability of having parameters with default value
 */
extension BaseServiceProtocol {
    func get<T: Decodable>(baseUrl: URL? = BaseService.baseUrl, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        get(baseUrl: baseUrl, path: path, parameters: parameters, completion: completion)
    }

    func post<T: Decodable>(baseUrl: URL? = BaseService.baseUrl, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        post(baseUrl: baseUrl, path: path, parameters: parameters, completion: completion)
    }
}

/*
 The Base Service will use the actual Alamofire implementation
*/
class BaseService: Service {
    static let shared = BaseService()

    static fileprivate var baseUrl = URL(string: "https://api.github.com/")

    var headers: [String: String] = [:]

    /*
     Setting the authorization header and using only authorized requests after it has been set.
     */
    func setupAuthorization(with token: AccessToken) {
        headers["Authorization"] = "token \(token.access_token)"
    }
}

extension BaseService: BaseServiceProtocol {
    func get<T: Decodable>(baseUrl: URL? = BaseService.baseUrl, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        if let url = baseUrl?.appendingPathComponent(path) {
            request(url: url, method: .get, parameters: parameters, headers: headers, completion: completion)
        }
    }

    func post<T: Decodable>(baseUrl: URL? = BaseService.baseUrl, path: String, parameters: [String: String], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        if let url = baseUrl?.appendingPathComponent(path) {
            request(url: url, method: .post, parameters: parameters, headers: headers, completion: completion)
        }
    }
}

class Service {
    fileprivate init() {}

    fileprivate func request<T: Decodable>(url: URL, method: HTTPMethod, parameters: [String: String], headers: [String: String] = [:], completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        var headers = headers
        headers["Accept"] = "application/json"

        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
            do {
                if response.result.isSuccess, let json = response.result.value {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let obj = try JSONDecoder().decode(T.self, from: data)
                    completion(Swift.Result.success(obj))
                }
            } catch {
                completion(Swift.Result.failure(ParsingError()))
            }
        }
    }

    private class ParsingError: Error {}
}
