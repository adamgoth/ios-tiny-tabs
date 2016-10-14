//
//  Restaurant.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/14/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation

class Restaurant {
    fileprivate var _id: String
    fileprivate var _name: String
    fileprivate var _neighborhood: String
    fileprivate var _address1: String
    
    var id: String {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    var neighborhood: String {
        return _neighborhood
    }
    
    var address1: String {
        return _address1
    }
    
    init(id: String, name: String, neighborhood: String, address1: String) {
        self._id = id
        self._name = name
        self._neighborhood = neighborhood
        self._address1 = address1
    }
}
