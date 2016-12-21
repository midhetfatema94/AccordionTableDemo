//
//  Structure.swift
//  Accordion
//
//  Created by Midhet Sulemani on 21/12/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import Foundation

struct Label {
    var parent: String!
    var child: [String]!
    
    init(object: Dictionary<String, Any>) {
        
        self.parent = object["parent"] as! String
        self.child = object["child"] as! Array
    }
}
