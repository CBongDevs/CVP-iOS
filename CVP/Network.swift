//
//  Network.swift
//  CVP
//
//  Created by Andrew Thompson on 24/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    
    static let fallbackData: [Task] = [
        Task(id: 0,
             title: "CVP",
             category: "programming",
             description: "We're building a platform to connect people in need with volunteers. Accept this task to join the project!",
             datePosted: "Today",
             completionStatus: .open,
             postedById: 0,
             contactPhone: "0478 707 546",
             address: "14 Beauty Point Road"),
        Task(id: 0,
             title: "Notation",
             category: "maths",
             description: "I'm making a maths app to help people communicate mathematics on iPads. Who want's to help?",
             datePosted: "Today",
             completionStatus: .open,
             postedById: 0,
             contactPhone: "0478 707 546",
             address: "14 Beauty Point Road"),
        Task(id: 0,
             title: "Word Graphs",
             category: "music",
             description: "Anyone interested in natural language processing? Linguists are welcome.",
             datePosted: "Today",
             completionStatus: .open,
             postedById: 0,
             contactPhone: "0478 707 546",
             address: "14 Beauty Point Road"),
        Task(id: 0,
             title: "ned help",
             category: "donno",
             description: "Dont no wat hapnd, ned to set up my bed",
             datePosted: "Today",
             completionStatus: .open,
             postedById: 0,
             contactPhone: "0478 707 546",
             address: "14 Beauty Point Road"),
    ]
    
    static func requestTasks(completion: @escaping ([Task]) -> ()) {
        Alamofire.request("https://localhost:3000/tasks").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        completion(try JSONDecoder().decode([Task].self, from: data))
                        return
                    } catch {
                        print(error)
                    }
                }
            } else {
                print(response.error!)
            }
            print("using fallback data")
            completion(fallbackData)
        }
    }
}
