//
//  Data.swift
//  CVP
//
//  Created by Andrew Thompson on 24/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import Foundation

struct Task: Codable {
    
    enum Status: Int, Codable, CustomStringConvertible {
        case open = 0
        case volunteered = 1
        case completed = 2
        
        var description: String {
            switch self {
            case .open: return "Open"
            case .volunteered: return "Volunteered"
            case .completed: return "Completed"
            }
        }
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
}

