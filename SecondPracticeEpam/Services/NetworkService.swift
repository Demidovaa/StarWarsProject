//
//  NetworkService.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 15.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Moya

enum RequestResult {
    case success([APIPerson]?)
    case failure
}

typealias PersonSearchCompletion = (RequestResult, Int) -> (Void)

class NetworkService {
    let apiProvider = MoyaProvider<PersonSearchAPI>(plugins: [NetworkLoggerPlugin(), MoyaCacheablePlugin()])
    
    func search(for text: String, completion: @escaping PersonSearchCompletion) {
        apiProvider.request(.search(text)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(PersonSearchResponse.self, from: response.data)
                completion(.success(data?.results), data?.count ?? 0)
            case .failure:
                completion(.failure, 0)
            }
        }
    }
}
