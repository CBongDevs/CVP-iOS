//
//  DetailViewController.swift
//  CVP
//
//  Created by Andrew Thompson on 24/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskField", for: indexPath)
        
        if let task = self.task {
            let path = Task.keyPaths[indexPath.row].path
            if let object = task[keyPath: path] as? CustomStringConvertible {
                cell.detailTextLabel?.text = object.description
                cell.textLabel?.text = Task.keyPaths[indexPath.row].title
            }
        }
        
        return cell
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if task != nil {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var task: Task? {
        didSet {
            configureView()
        }
    }
}

