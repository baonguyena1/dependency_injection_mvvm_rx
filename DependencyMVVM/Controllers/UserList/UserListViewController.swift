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
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerInjector: ViewControllerInjecting!
    var viewModel: UserListViewModel!
    
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
        
        viewModel.output.users
            .subscribe(onNext: { [weak self] (_) in
                self?.tableView.reloadData()
            })
            .disposed(by: self.bag)
    }
    
    private func getUsers() {
        viewModel.getUsers()
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getCellViewModel(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListItemCell.cellIdentifier, for: indexPath) as! UsersListItemCell
        cell.configure(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = self.viewControllerInjector.inject(viewcontroller: ViewIdentifier.userDetailViewController, in: Storyboard.user) as? UserDetailViewController {
            let user = viewModel.getUser(for: indexPath.row)
            controller.viewModel.setupUser(user)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension UserListViewController {
    func showErrorAlert(with message: String) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
