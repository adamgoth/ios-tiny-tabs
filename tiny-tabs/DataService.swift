//
//  DataService.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/12/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let ds = DataService()
    
    fileprivate var _ref = FIRDatabase.database().reference()
    fileprivate var _specials_ref = FIRDatabase.database().reference(fromURL: "https://ios-tiny-tabs.firebaseio.com/specials")
    
    var ref: FIRDatabaseReference {
        return _ref
    }
    
    var specials_ref: FIRDatabaseReference {
        return _specials_ref
    }

}
