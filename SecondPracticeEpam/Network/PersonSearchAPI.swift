//
//  PersonSearchAPI.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 01.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Moya

enum PersonSearchAPI {
    case search(String)
}

extension PersonSearchAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://swapi.co/api")!
    }
    
    var method: Moya.Method {
        return .get
    }
    var path: String {
        return "/people/"
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let string):
            return .requestParameters(parameters: ["search": string],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
