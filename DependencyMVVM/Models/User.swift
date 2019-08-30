//
//  User.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation

class User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}
