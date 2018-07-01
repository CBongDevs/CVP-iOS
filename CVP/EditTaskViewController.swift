//
//  EditTaskViewController.swift
//  CVP
//
//  Created by Andrew Thompson on 28/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import UIKit

class EditTaskViewController: UITableViewController {
    
    var sectionTitles = ["Details", "Description"]
    var editableFields = ["Title", "Category"]
    
    var task: Task? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        if task != nil {
            tableView.reloadData()
            navigationItem.title = task!.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return editableFields.count + 1
        } else {
            return 2 // Description + Text Field
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            cell.setViewText(with: 19, text: sectionTitles[indexPath.section])
            return cell
        } else if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath)
            
            cell.setViewText(with: 19, text: editableFields[indexPath.row - 1])
            if let task = self.task {
                let value = indexPath.row == 1 ? task.title : task.category
                cell.setViewText(with: 29, text: value.capitalized)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
            if let d = task?.description {
                cell.setViewText(with: 19, text: d)
                cell.sizeToFit()
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
