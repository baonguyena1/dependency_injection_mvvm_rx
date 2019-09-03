//
//  UserDetailViewController.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 9/3/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController, ControllerInjector {
    var viewControllerInjector: ViewControllerInjecting!
    var viewModel: UserDetailViewModel!
    
    var user: User!
    
    private let bag = DisposeBag()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        getUserProfile()
    }
    
    private func setupRx() {
        viewModel.output.isLoading
            .subscribe(onNext: { [weak self] (isLoading) in
                isLoading ?
                    self?.activityIndicator.startAnimating()
                    : self?.activityIndicator.stopAnimating()
            })
            .disposed(by: self.bag)
        
        viewModel.output.error
            .subscribe(onNext: { [weak self] (error) in
                self?.showErrorAlert(with: error)
            })
            .disposed(by: self.bag)
        
        viewModel.output.user
            .subscribe(onNext: { [weak self] (_) in
                guard let `self` = self else { return }
                self.displayUserProfile(user: self.viewModel.output.profile)
            })
            .disposed(by: self.bag)
    }
    
    private func getUserProfile() {
        viewModel.getUserProfile()
    }
    
    private func displayUserProfile(user: User) {
        print(user)
    }
}

extension UserDetailViewController {
    func showErrorAlert(with message: String) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
