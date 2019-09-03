//
//  CellIdentifier.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 9/3/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

protocol CellIdentifier {
    static var cellIdentifier: String { get }
}

extension CellIdentifier where Self: UIView {
    static var cellIdentifier: String { return String(describing: self) }
}
