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
        registerHandlers()
    }
    
    class func registerStoryboards() {
        Container.loggingFunction = nil
        
    }
    
    class func registerViewModels() {
        
    }
    
    class func registerServices() {
        defaultContainer.register(ViewControllerInjecting.self) { _ in
            ViewControllerInjector()
        }
    }
    
    class func registerHandlers() {
        
    }
}
