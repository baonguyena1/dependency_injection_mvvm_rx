//
//  String+Helper.swift
//  PeopleRoulette
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation

extension String: Error {}

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
