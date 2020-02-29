//
//  DatabaseService.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 22.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var hair: String = ""
    @objc dynamic var skin: String = ""
    @objc dynamic var eye: String = ""
    @objc dynamic var birth: String = ""
    @objc dynamic var gender: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(from person: APIPerson) {
        self.init()
        self.name = person.name
        self.height = person.height
        self.mass = person.mass
        self.hair = person.hair_color
        self.skin = person.skin_color
        self.eye = person.eye_color
        self.birth = person.birth_year
        self.gender = person.gender
    }
}

class DatabaseService {
    func save(object: Object) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func get() -> [Person] {
        do {
            let realm = try Realm()
            let obj = realm.objects(Person.self)
            return Array(obj)
        }
        catch (let error) {
            print(error)
            return []
        }
    }
    
    func remove(object: Object) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
}
