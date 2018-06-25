//
//  Data.swift
//  CVP
//
//  Created by Andrew Thompson on 24/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import Foundation

struct Task: Codable {
    
    enum Status: Int, Codable {
        case open = 0
        case volunteered = 1
        case completed = 2
    }
    
    var title: String
    var id: Int
    var category: String
    var description: String
    var datePosted: String
    var completionStatus: Status
    var postedById: Int
    var contactPhone: String
    var address: String
    
    init(id: Int, title: String, category: String, description: String, datePosted: String, completionStatus: Status, postedById: Int, contactPhone: String, address: String) {
        self.id = id
        self.title = title
        self.category = category
        self.description = description
        self.datePosted = datePosted
        self.completionStatus = completionStatus
        self.postedById = postedById
        self.contactPhone = contactPhone
        self.address = address
    }
    
    static var keyPaths: [(title: String, path: PartialKeyPath<Task>)] {
        get {
            return [("title", \Task.title),
                    ("id", \Task.id),
                    ("categories", \Task.category),
                    ("description", \Task.description),
                    ("dataPosted", \Task.datePosted),
                    ("completionStatus", \Task.completionStatus),
                    ("postedByID", \Task.postedById),
                    ("contactPhoneNumber", \Task.contactPhone),
                    ("address", \Task.address)]
        }
    }
}

