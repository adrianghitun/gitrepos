//
//  ImageDownloader.swift
//  GitHubRepos
//
//  Created by Adrian Ghitun on 23/10/2019.
//  Copyright © 2019 Adrian Ghitun. All rights reserved.
//

import Foundation
import AlamofireImage

/*
 Exposing the functionality via a protocol, hiding the Alamofire implementation.
 */
protocol ImageDownloaderProtocol: class {
    /*
     The completion block callback type is going to be Any since we want to avoid passing around with UIKit elements, thus breaking MVVM principles.
     */
    func image(for url: URL, completion: @escaping (Any?) -> Void)
}

class ImageDownloader: ImageDownloaderProtocol {
    private let imageDownloader = AlamofireImage.ImageDownloader()

    func image(for url: URL, completion: @escaping (Any?) -> Void) {
        imageDownloader.download(URLRequest(url: url)) { response in
            completion(response.value)
        }
    }
}
