//
//  MoyaCachable.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 04.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}
