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
    let hair: String
    let skin: String
    let eye: String
    let birth: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hair = "hair_color"
        case skin = "skin_color"
        case eye = "eye_color"
        case birth = "birth_year"
        case gender
    }
}

struct PersonSearchResponse: Decodable {
    let count: Int
    let results: [APIPerson]
}
