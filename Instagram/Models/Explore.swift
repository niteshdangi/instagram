//
//  Explore.swift
//  Instagram
//
//  Created by Nitesh Kumar3 on 14/05/23.
//

import Foundation


struct Explore: Hashable, Codable {
    let grid: [String]
    let vertical: String?
    let isReverse: Bool?
    let square: String?
}
