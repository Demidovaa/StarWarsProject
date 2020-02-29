//
//  NetworkManager.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 15.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Moya

// TO READ:
// completion handlers aka closures
// @escaping non-escaping closures

// TODO:
// Rename NetworkManager

struct APIPerson: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
}

struct PersonSearchResponse: Decodable {
    let count: Int
    let results: [APIPerson]
}

//
typealias PersonSearchCompletion = ([APIPerson]?) -> (Void)

class NetworkManager {
    let provider = MoyaProvider<PersonSearchAPI>()
    
    func search(for text: String, completion: @escaping PersonSearchCompletion) {
        provider.request(.search(text)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(PersonSearchResponse.self,
                                                from: response.data)
                completion(data?.results)
            case .failure:
                completion(nil)
            }
        }
    }
}
//

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
