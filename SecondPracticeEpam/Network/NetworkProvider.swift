//
//  NetworkProvider.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 04.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Alamofire
import Moya

final class NetworkProvider<T>: MoyaProvider<T> where T: TargetType {
    override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                  requestClosure: @escaping RequestClosure = MoyaProvider<T>.defaultRequestMapping,
                  stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                  callbackQueue: DispatchQueue? = nil,
                  manager: Manager = DefaultAlamofireManager.managerWithTimeout,
                  plugins: [PluginType] = [],
                  trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   callbackQueue: callbackQueue,
                   manager: manager,
                   plugins: [NetworkLoggerPlugin(), MoyaCacheablePlugin()],
            trackInflights: trackInflights)
    }
}
