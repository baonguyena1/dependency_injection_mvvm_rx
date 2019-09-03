//
//  UserListItemCellViewModel.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 9/3/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation

class UserListItemCellViewModel {
    var user: User!
    
    var name: String? { return user.name }
    var company: String? { return user.company?.name }
    
    init(user: User) {
        self.user = user
    }
}
