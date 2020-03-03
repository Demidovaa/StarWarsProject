//
//  Debounce.swift
//  SecondPracticeEpam
//
//  Created by Анастасия Демидова on 03.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

class Debouncer {
    
    var currentWorkItem: DispatchWorkItem?

    func debounce(delay: DispatchTimeInterval, action: @escaping ((String) -> Void)) -> (String) -> Void {
        return {  [weak self] parameter in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action(parameter) }
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}
