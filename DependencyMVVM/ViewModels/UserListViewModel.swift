//
//  UserListViewModel.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserListViewModel: ViewModelType {
    var input: UserListViewModel.Input
    var output: UserListViewModel.Output
    
    var service: UserService!    
    
    struct Input { }
    
    struct Output {
        var users = PublishRelay<[User]>()
        var error = PublishRelay<String>()
    }

    private let bag = DisposeBag()
    
    init() {
        input = Input()
        output = Output()
    }
    
    func getUsers() {
        service.getUsers()
            .subscribe(onSuccess: { [weak self] (users) in
                self?.output.users.accept(users)
            }) { [weak self] (error) in
                self?.output.error.accept(error.localizedDescription)
            }
            .disposed(by: self.bag)
    }
}
