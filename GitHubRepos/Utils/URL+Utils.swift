//
//  URL+Utils.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 22/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

extension URL {
    var params : [String: String] {
        var dict = [String: String]()

        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    guard let value = item.value else { continue }
                    dict[item.name] = value
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
