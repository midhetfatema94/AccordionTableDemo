//
//  MainTableViewController.swift
//  Accordion
//
//  Created by Midhet Sulemani on 19/12/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var labels: [String] = []
    
    var isExpanded = false
    var childCells = 0
    var selectedIndex: Int!
    var allLabels: [Label] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVar()
        
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
        
        if (isExpanded == true) {
            if(selectedIndex == (indexPath as NSIndexPath).item) {
                
                isExpanded = false
                print("in if statement 1")
                expandParent(isExpanded, index: selectedIndex)
                
            }
                
            else {
                let prevIndex = selectedIndex
                expandParent(false, index: selectedIndex)
                isExpanded = true
                if(prevIndex! < (indexPath as NSIndexPath).item) {
                    selectedIndex = (indexPath as NSIndexPath).item - childCells
                    print("in if statement 2")
                } else {
                    selectedIndex = (indexPath as NSIndexPath).item
                    print("in if statement 4")
                }
                
                expandParent(isExpanded, index: selectedIndex)
                
            }
            
            
        }
            
        else {
            isExpanded = true
            selectedIndex = (indexPath as NSIndexPath).item
            print("in if statement 3")
            expandParent(isExpanded, index: (indexPath as NSIndexPath).item)
        }
    }
    
    //MARK: - Expand Parent
    
    func expandParent(_ isExpanded: Bool, index: Int) -> Void {
        
        if(isExpanded == true) {
            
            childCells = allLabels[index].child.count + 1
            for j in 0 ..< childCells {
                labels.insert("child", at: index + 1 + j)
            }
            tableView.reloadData()
        }
            
        else if(isExpanded == false) {
            
            for _ in 0 ..< childCells {
                labels.remove(at: index+1)
            }
            tableView.reloadData()
            
        }
    }
    
    //Initializing struct
    
    func initializeVar() {
        
        var flag = ["Header", "Mumbai", "Delhi", "Chennai", "Kolkata", "Bengaluru", "Hyderabad"]
        
        for i in 0 ..< flag.count {
            
            var myChild: [String] = []
            
            for _ in 0 ..< i {
                
                myChild.append("child")
            }
            
            allLabels.append(Label(object: ["parent": "parent", "child": myChild]))
        }
        
        labels = flag
        tableView.reloadData()
    }
}
