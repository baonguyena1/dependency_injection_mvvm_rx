//
//  UserListViewController.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 8/30/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserListViewController: UIViewController, ControllerInjector {
    var viewControllerInjector: ViewControllerInjecting!
    var model: UserListViewModel!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        getUsers()
    }
    
    private func setupRx() {
        model.output.isLoading
            .subscribe(onNext: { [weak self] (isLoading) in
                print(isLoading)
            })
            .disposed(by: self.bag)
        
        model.output.error
            .subscribe(onNext: { [weak self] (error) in
                print(error)
            })
            .disposed(by: self.bag)
        
        model.output.users
            .subscribe(onNext: { [weak self] (users) in
                print(users)
            })
            .disposed(by: self.bag)
    }
    
    func getUsers() {
        model.getUsers()
    }

}
