//
//  Student.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import Foundation

struct Student: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case creds
        case firstSubjectPoints
        case secondSubjectPoints
        case address
    }
    
    var id = UUID()
    let creds: String
    let firstSubjectPoints: Int64
    let secondSubjectPoints: Int64
    let address: String
    
}
