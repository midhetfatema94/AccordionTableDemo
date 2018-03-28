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
        return labels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if labels[indexPath.row] == "child" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath)
            cell.textLabel?.text = labels[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentCell", for: indexPath)
        cell.textLabel?.text = labels[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == "parentCell" {
            if isExpanded {
                if selectedIndex == (indexPath as NSIndexPath).item {
                    isExpanded = false
                }
                else {
                    let prevIndex = selectedIndex
                    expandParent(false, index: selectedIndex)
                    isExpanded = true
                    if prevIndex! < (indexPath as NSIndexPath).item {
                        selectedIndex = (indexPath as NSIndexPath).item - childCells
                    } else {
                        selectedIndex = (indexPath as NSIndexPath).item
                    }
                }
            }
            else {
                isExpanded = true
                selectedIndex = (indexPath as NSIndexPath).item
            }
            expandParent(isExpanded, index: selectedIndex)
        }
    }
    
    //MARK: - Expand Parent
    
    func expandParent(_ isExpanded: Bool, index: Int) -> Void {
        
        if isExpanded {
            
            childCells = allLabels[index].child.count + 1
            
            for j in 0 ..< childCells {
                
                labels.insert("child", at: index + 1 + j)
            }
            tableView.reloadData()
        }
            
        else if(isExpanded == false) {
            
            for _ in 0 ..< childCells {
                
                labels.remove(at: index + 1)
            }
            tableView.reloadData()
        }
    }
    
    //Initializing struct
    
    func initializeVar() {
        
        let flag = ["Mumbai", "Delhi", "Chennai", "Kolkata", "Bengaluru", "Hyderabad"]
        
        for i in 0 ..< flag.count {
            
            var myChild: [String] = []
            
            for _ in 0 ..< i {
                myChild.append("child")
            }
            allLabels.append(Label(object: ["parent": flag[i], "child": myChild]))
        }
        
        labels = flag
        tableView.reloadData()
    }
}
