//
//  Debounce.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 03.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

fileprivate var currentWorkItem: DispatchWorkItem?

func debounce(delay: DispatchTimeInterval, action: @escaping ((String) -> Void)) -> (String) -> Void {
    return { parameter in
        currentWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            action(parameter)
        }
        currentWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
}
