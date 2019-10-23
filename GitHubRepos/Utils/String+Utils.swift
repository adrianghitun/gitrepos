//
//  String+Utils.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 24/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation

extension String {
   static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
