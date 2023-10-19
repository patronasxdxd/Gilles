//
//  Task.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import Foundation
struct Task: Codable {
    let id: Int?
    var description: String
    var isDone: Bool
}
