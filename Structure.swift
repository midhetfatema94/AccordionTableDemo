//
//  Structure.swift
//  Accordion
//
//  Created by Midhet Sulemani on 21/12/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import Foundation

//Structure created to store all your objects of chil and parent cell here
struct Label {
    var parent: String!
    var child: [String]!
    init(object: [String: Any]) {
        self.parent = object["parent"] as! String
        self.child = object["child"] as! Array
    }
}
