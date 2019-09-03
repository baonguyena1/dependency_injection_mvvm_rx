//
//  UsersListItenCell.swift
//  DependencyMVVM
//
//  Created by Bao Nguyen on 9/3/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

class UsersListItemCell: UITableViewCell, CellIdentifier {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: UserListItemCellViewModel) {
        nameLabel.text = viewModel.name
        companyLabel.text = viewModel.company
    }
}
