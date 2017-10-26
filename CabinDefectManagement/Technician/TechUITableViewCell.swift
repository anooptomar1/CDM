//
//  TechUITableViewCell.swift
//  CabinDefectManagement
//
//  Created by qwerty on 25/10/17.
//  Copyright © 2017 Sim Kim Wee. All rights reserved.
//

import UIKit

class TechUITableViewCell: UITableViewCell {
    @IBOutlet weak var DefectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
