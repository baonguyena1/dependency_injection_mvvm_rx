//
//  UserService.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class UserService: APIInjector {
    var apiHandler: APIRequestHandler!
    
    func getUsers() -> Single<[User]> {
        let request = APIRequest(endpoint: .users)
        return apiHandler.sendRequestResponseArray(request)
    }
}
