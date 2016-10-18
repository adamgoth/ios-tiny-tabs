//
//  Neighborhood.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/18/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation

class Neighborhood {
    var _id: String!
    var _name: String!
    
    var id: String {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    init(id: String, name: String) {
        self._id = id
        self._name = name
    }
}
