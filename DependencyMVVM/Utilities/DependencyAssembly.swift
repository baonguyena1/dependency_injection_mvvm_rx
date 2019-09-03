//
//  DependencyAssembly.swift
//  PeopleRoulette
//
//  Created by Bao Nguyen on 8/29/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        registerStoryboards()
        registerViewModels()
        registerServices()
    }
    
    class func registerStoryboards() {
        Container.loggingFunction = nil
        defaultContainer.storyboardInitCompleted(UserListViewController.self) { (r, c) in
            c.viewModel = r.resolve(UserListViewModel.self)
            c.viewControllerInjector = r.resolve(ViewControllerInjecting.self)
        }
        
        defaultContainer.storyboardInitCompleted(UserDetailViewController.self) { (r, c) in
            c.viewModel = r.resolve(UserDetailViewModel.self)
            c.viewControllerInjector = r.resolve(ViewControllerInjecting.self)
        }
    }
    
    class func registerViewModels() {
        defaultContainer.register(UserListViewModel.self) { r in
            let viewModel = UserListViewModel()
            viewModel.service = r.resolve(UserService.self)
            return viewModel
        }
        
        defaultContainer.register(UserDetailViewModel.self) { r in
            let viewModel = UserDetailViewModel()
            viewModel.service = r.resolve(UserService.self)
            return viewModel
        }
    }
    
    class func registerServices() {
        defaultContainer.register(ViewControllerInjecting.self) { _ in ViewControllerInjector() }.inObjectScope(.container)
        
        defaultContainer.register(APIRequestHandler.self) { _ in APIRequestHandler() }.inObjectScope(.container)
        
        defaultContainer.register(UserService.self) { r in
            let service = UserService()
            service.apiHandler = r.resolve(APIRequestHandler.self)
            return service
        }.inObjectScope(.container)
    }
}
