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
        Task(id: 0, title: "CVP", category: "programming", description: "make a community volunteer project", datePosted: "Today", completionStatus: .open, postedById: 0, contactPhone: "0478 707 546", address: "14 Beauty Point Road"),
        Task(id: 0, title: "Fractal Milking", category: "maths", description: "milking fractals...", datePosted: "Today", completionStatus: .open, postedById: 0, contactPhone: "0478 707 546", address: "14 Beauty Point Road"),
        Task(id: 0, title: "Music Improvisation", category: "music", description: "Who want's to learn how to improvise?", datePosted: "Today", completionStatus: .open, postedById: 0, contactPhone: "0478 707 546", address: "14 Beauty Point Road"),
    ]
    
    static func requestTasks(completion: @escaping ([Task]) -> ()) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
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
