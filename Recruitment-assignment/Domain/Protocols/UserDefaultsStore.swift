//
//  UserDefaultsStore.swift
//  Recruitment-assignment
//
//  Created by Patryk Maciąg on 17/02/2024.
//

import Foundation

protocol UserDefaultsStore {
    associatedtype T
    associatedtype U
    
    var defaults: UserDefaults { get }
    
    func get() -> U
    func add(_: T)
    func delete(_: T)
    
}
