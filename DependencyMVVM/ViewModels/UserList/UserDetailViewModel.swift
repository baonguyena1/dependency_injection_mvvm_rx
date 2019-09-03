//
//  UserDetailViewModel.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 9/3/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserDetailViewModel: ViewModelType {
    var input: UserDetailViewModel.Input
    var output: UserDetailViewModel.Output
    
    var service: UserService!
    
    private var user: User!
    
    struct Input { }
    
    struct Output {
        var user = PublishRelay<User>()
        var error = PublishRelay<String>()
        var isLoading = PublishRelay<Bool>()
        var profile: User!
    }
    
    private let bag = DisposeBag()
    
    init() {
        input = Input()
        output = Output()
    }
    
    func setupUser(_ user: User) {
        self.user = user
    }
    
    func getUserProfile() {
        var userId = ""
        if let id = user.id {
            userId = "\(id)"
        }
        service.getUserProfile(userId: userId)
            .subscribe(onSuccess: { [weak self] (user) in
                self?.output.profile = user
                self?.output.user.accept(user)
            }) { [weak self] (error) in
                self?.output.error.accept(error.localizedDescription)
            }
            .disposed(by: bag)
    }
}
