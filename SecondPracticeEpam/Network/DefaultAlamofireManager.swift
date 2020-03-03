//
//  DefaultAlamofireManager.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 04.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAlamofireManager: Alamofire.Manager {
    static let managerWithTimeout: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 5
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
