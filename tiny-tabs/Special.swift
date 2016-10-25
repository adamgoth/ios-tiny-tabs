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
    fileprivate var _days: [String: Bool]!
    fileprivate var _time: String!
    fileprivate var _drink: String!
    fileprivate var _food: String!
    fileprivate var _website: String!
    
    var restaurantId: String {
        return _restaurantId
    }
    
    var days: [String: Bool] {
        return _days
    }
    
    var time: String {
        return _time
    }
    
    var drink: String {
        return _drink
    }
    
    var food: String {
        return _food
    }
    
    var website: String {
        return _website
    }
    
    init(restaurantId: String, time: String, drink: String, food: String, days: [String: Bool], website: String) {
        _restaurantId = restaurantId
        _days = days
        _time = time
        _drink = drink
        _food = food
        _website = website
    }
    
    
}
