//
//  MainTableViewController.swift
//  Accordion
//
//  Created by Midhet Sulemani on 19/12/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var labels = ["parent", "parent", "parent", "parent", "parent"]
    var allLabels: [Label]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0 ..< 5 {
            
            var myChild: [String] = []
            
            for _ in 0 ..< i {
                
                myChild.append("child")
            }
            
            allLabels.append(Label(object: ["parent": "parent", "child": myChild]))
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return labels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if labels[indexPath.row] == "child" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentCell", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        appendIntoLabel(thisArray: allLabels[indexPath.row].child, atIndex: indexPath.row)
        
    }
    
    func appendIntoLabel(thisArray: [String], atIndex: Int) {
        
        for label in labels {
            
            if label == "child" {
                
                labels.remove(at: labels.index(of: label)!)
            }
        }
        
        for eachString in thisArray {
            
            let index = thisArray.index(of: eachString)
            labels.insert(eachString, at: atIndex + index!)
            
        }
        
        tableView.reloadData()
    }
}
