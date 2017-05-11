//
//  MainTableViewController.swift
//  Accordion
//
//  Created by Midhet Sulemani on 19/12/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var labels: [[String: Any]] = [["parent": "Mumbai", "child": ["child one"]], ["parent": "Delhi", "child": ["child one", "child one"]], ["parent": "Chennai", "child": ["child one", "child one", "child one"]], ["parent": "Kolkata", "child": ["child one", "child one", "child one", "child one", "child one"]], ["parent": "Bengaluru", "child": ["child one", "child one", "child one", "child one", "child one"]], ["parent": "Hyderabad", "child": ["child one", "child one", "child one", "child one", "child one"]]]
    
    var isExpanded = false
    var childCells = 0
    var selectedIndex = 0
//    var allLabels: [Label] = []
    var initialView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initializeVar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        initialView = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return labels.count + childCells
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == selectedIndex - 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentCell", for: indexPath)
        
        if initialView {
            cell.tag = indexPath.row + 1
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.tag != 0 {
            
            if isExpanded == true {
                if selectedIndex == cell?.tag {
                    
                    isExpanded = false
                    print("in if statement 1")
                    expandParent(isExpanded: isExpanded, index: selectedIndex - 1)
                    
                }
                    
                else {
                    
                    let prevIndex = selectedIndex - 1
                    expandParent(isExpanded: false, index: selectedIndex - 1)
                    isExpanded = true
                    if prevIndex < indexPath.row {
                        
                        self.selectedIndex = indexPath.row - self.childCells
                        print("in if statement 2")
                    
                    } else {
                        
                        selectedIndex = (cell?.tag)!
                        print("in if statement 4")
                        
                    }
                    
                    expandParent(isExpanded: isExpanded, index: selectedIndex)
                    
                }
                
                
            }
                
            else {
                isExpanded = true
                selectedIndex = indexPath.row
                print("in if statement 3")
                expandParent(isExpanded: isExpanded, index: (cell?.tag)! - 1)
            }
            
            tableView.reloadData()
        }
    }
    
    //MARK: - Expand Parent
    
    func expandParent(isExpanded: Bool, index: Int) -> Void {
        
        if isExpanded == true {
            
            let childArray = labels[index]["child"] as! [String]
            childCells = childArray.count + 1
//            for j in 0 ..< childCells {
//                labels.insert("child", at: index + 1 + j)
//            }
//            tableView.reloadData()
        }
            
        else if isExpanded == false {
            
            childCells = 0
        }
        
        tableView.reloadData()
    }
//
//    func collapseParent(index: Int) -> Void {
//        
//        
//            
//        
//            
//        
//    }
    //Initializing struct
    
//    func initializeVar() {
//        
//        
//        for i in 0 ..< labels.count {
//            
//            var myChild: [String] = []
//            
//            for _ in 0 ..< i {
//                
//                myChild.append("child")
//            }
//            
//            allLabels.append(Label(object: ["parent": "parent", "child": myChild]))
//        }
//        
//        tableView.reloadData()
//    }
}
