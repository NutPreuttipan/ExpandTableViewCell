//
//  ViewController.swift
//  ExpandTableViewCell
//
//  Created by Preuttipan Janpen on 1/3/2562 BE.
//  Copyright © 2562 Lphant Solutions. All rights reserved.
//

import UIKit

struct item {
    var isExpand:Bool = false
    var txt:[String] = ["null"]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableViewList: UITableView!
    var itemList:[item]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        itemList = [item(isExpand: false, txt: ["a","b","c"]),
                    item(isExpand: false, txt: ["b","c"]),
                    item(isExpand: false, txt: ["c","d","e","f"])]
        
        
        tableViewList.register(UINib(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList[section].txt.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if itemList[indexPath.section].isExpand == true {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableViewList.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! SectionHeader
        
        headerView.customInit(month: "Open", section: section, delegate: self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewList.dequeueReusableCell(withIdentifier: "cellSubExpand", for: indexPath)
        
        cell.textLabel?.text = itemList[indexPath.section].txt[indexPath.row]
        return cell
    }
}

extension ViewController: SectionHeaderViewDelegate {
    func toggleSection(header: SectionHeader, section: Int) {
        
        itemList[section].isExpand = !itemList[section].isExpand
        
        if itemList[section].isExpand {
            header.customInit(month: "Close", section: section, delegate: self)
        } else {
            header.customInit(month: "Open", section: section, delegate: self)
        }
        
        tableViewList.beginUpdates()
        for i in 0 ... itemList[section].txt.count - 1 {
            tableViewList.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableViewList.endUpdates()
    }
}
