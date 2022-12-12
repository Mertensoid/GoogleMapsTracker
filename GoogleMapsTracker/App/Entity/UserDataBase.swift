//
//  UserDataBase.swift
//  GoogleMapsTracker
//
//  Created by admin on 11.12.2022.
//

import Foundation

class UserDataBase {
    var users: [User] = []
    
    static let instance = UserDataBase()
    
    private init() {
    }
}
