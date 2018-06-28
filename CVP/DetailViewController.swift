//
//  DetailViewController.swift
//  CVP
//
//  Created by Andrew Thompson on 24/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import UIKit
import Alamofire

private extension Task {
    static var keyPaths: [(title: String, path: PartialKeyPath<Task>)] {
        get {
            return [
                ("Status", \Task.completionStatus),
                ("Posted", \Task.datePosted),
                ("Category", \Task.category),
            ]
        }
    }
}

extension UIView {
    func setViewText(with tag: Int, text: String) {
        if let view = viewWithTag(tag) {
            if let label = view as? UILabel {
                label.text = text
            }
        }
    }
}

class DetailViewController: UITableViewController {
    
    var hiddenSections: [Bool] = [false, false]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return hiddenSections[0] ? 1 : Task.keyPaths.count + 1
        } else {
            return hiddenSections[1] ? 1 : 2
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return hiddenSections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath)
            
            if let task = self.task {
                let index = indexPath.row - 1
                let path = Task.keyPaths[index].path
                if let object = task[keyPath: path] as? CustomStringConvertible {
                    cell.setViewText(with: 19, text: Task.keyPaths[index].title)
                    cell.setViewText(with: 29, text: object.description.capitalized)
                }
            }
            
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
                cell.setViewText(with: 19, text: "Description")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
                if let description = task?.description {
                    cell.setViewText(with: 19, text: description)
                    cell.sizeToFit()
                }
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // collapse children...
        tableView.beginUpdates()
        let paths: [IndexPath]
        if indexPath.section == 0 {
            paths = (1..<(Task.keyPaths.count + 1)).map  { IndexPath(row: $0, section: indexPath.section) }
        }  else {
            paths = [IndexPath(row: 1, section: 1)]
        }
        if hiddenSections[indexPath.section] {
            tableView.insertRows(at: paths, with: .top)
        } else {
            tableView.deleteRows(at: paths, with: .top)
        }
        hiddenSections[indexPath.section] = !hiddenSections[indexPath.section]
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 53
        } else {
            return tableView.rowHeight
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if task != nil {
            self.tableView.reloadData()
            self.navigationItem.title = task!.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        configureView()
    }

    var task: Task? {
        didSet {
            configureView()
        }
    }
}

