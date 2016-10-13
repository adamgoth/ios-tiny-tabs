//
//  Special.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/12/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation

class Special {
    fileprivate var _restaurantId: String!
    fileprivate var _description: String!
    fileprivate var _days: [String: Bool]!
    
    var restaurantId: String {
        return _restaurantId
    }
    
    var description: String {
        return _description
    }
    
    var days: [String: Bool] {
        return _days
    }
    
    init(restaurantId: String, description: String, days: [String: Bool]) {
        _restaurantId = restaurantId
        _description = description
        _days = days
    }
    
    
}
