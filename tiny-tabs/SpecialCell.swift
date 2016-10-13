//
//  SpecialCell.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/12/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class SpecialCell: UITableViewCell {
    
    @IBOutlet weak var restaurantLbl: UILabel!
    @IBOutlet weak var neighborhoodLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var special: Special!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(special: Special) {
        print("Configuring cell...")
        self.special = special
        self.restaurantLbl.text = "need to fetch"
        self.neighborhoodLbl.text = "need to fetch"
        self.addressLbl.text = "need to fetch"
        self.descriptionLbl.text = special.description
    }

}
