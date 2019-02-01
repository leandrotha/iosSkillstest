//
//  AlbumCell.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 01/02/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
