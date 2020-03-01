//
//  DatabaseService.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 22.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import RealmSwift

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
