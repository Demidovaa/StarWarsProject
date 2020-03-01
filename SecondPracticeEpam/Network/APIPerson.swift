//
//  APIPerson.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 01.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

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
