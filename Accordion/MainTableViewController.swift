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
    
    var arrayForTable: [String] = []
    
    var isExpanded = false
    var childCells = 0
    var selectedIndex = 0
//    var allLabels: [Label] = []
    var initialView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVar()
        
    }
    
    func initializeVar() {
        
        for label in labels {
            
            arrayForTable.append(label["parent"] as! String)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        initialView = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayForTable.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == selectedIndex - 1 {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath)
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentCell", for: indexPath)
        cell.textLabel?.text = arrayForTable[indexPath.row]
        
        if initialView {
            
            cell.tag = indexPath.row + 1
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.tag != 0 {
            
            if isExpanded {
                
                if selectedIndex == cell?.tag {
                    
                    isExpanded = false
                    print("in if statement 1")
                    expandParent(isExpanded: isExpanded, index: selectedIndex)
                }
                else {
                    
                    let prevIndex = selectedIndex - 1
                    expandParent(isExpanded: false, index: prevIndex)
                    
                    isExpanded = true
                    selectedIndex = (cell?.tag)!
                    print("in if statement 2")
                    expandParent(isExpanded: isExpanded, index: selectedIndex)
                }
            }
            else {
                
                isExpanded = true
                selectedIndex = (cell?.tag)!
                print("in if statement 3")
                expandParent(isExpanded: isExpanded, index: selectedIndex - 1)
            }
            
            tableView.reloadData()
        }
    }
    
    //MARK: - Expand Parent
    
    func expandParent(isExpanded: Bool, index: Int) -> Void {
        
        let childArray = labels[index]["child"] as! [String]
        childCells = childArray.count + 1
        
        if isExpanded {
            
            for j in 0 ..< childCells {
                
                print("add index", index+j+1)
                arrayForTable.insert("child\(index + 1 + j)", at: index + 1 + j)
            }
        }
        else {
            
//            var arrayIndices: [Int] = []
            
            for j in 0 ..< childCells - 1 {
                
                print("remove index", index+j)
                arrayForTable.remove(at: index)
                print("array for table is", arrayForTable)
            }
        }
        
        print("array for table is", arrayForTable)
        
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

extension Array {
    
    mutating func remove(at indexes: [Int]) {
        
        for index in indexes.sorted(by: >) {
            
            remove(at: index)
        }
    }
}
