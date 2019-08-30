//
//  ViewControllerInjector.swift
//  PeopleRoulette
//
//  Created by Bao Nguyen on 8/29/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import SwinjectStoryboard

protocol ControllerInjector {
    var viewControllerInjector: ViewControllerInjecting! { get set }
}

protocol ViewControllerInjecting {
    func inject(viewcontroller identifier: String, in storyboard: String) -> UIViewController
}

struct ViewControllerInjector: ViewControllerInjecting {
    func inject(viewcontroller identifier: String, in storyboard: String) -> UIViewController {
        return SwinjectStoryboard.create(name: storyboard,
                                         bundle: nil,
                                         container: SwinjectStoryboard.defaultContainer)
            .instantiateViewController(withIdentifier: identifier)
    }
}
