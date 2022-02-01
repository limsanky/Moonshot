//
//  Mission.swift
//  Moonshot
//
//  Created by Sankarshana V on 2022/02/01.
//

import Foundation

struct Mission: Codable & Identifiable {
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
    
    struct CrewRole: Codable {
        let name: String?
        let role: String
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
}
