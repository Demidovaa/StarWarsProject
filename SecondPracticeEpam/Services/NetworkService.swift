//
//  NetworkService.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 15.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Moya

typealias PersonSearchCompletion = ([APIPerson]?) -> (Void)

class NetworkService {
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
