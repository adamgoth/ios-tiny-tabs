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
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var drinkLbl: UILabel!
    @IBOutlet weak var foodLbl: UILabel!
    
    var special: Special!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(special: Special, restaurant: Restaurant, neighborhood: Neighborhood) {
        self.special = special
        self.restaurantLbl.text = restaurant.name
        self.neighborhoodLbl.text = neighborhood.name
        self.addressLbl.text = restaurant.address1
        self.timeLbl.text = special.time
        self.drinkLbl.text = special.drink
        self.foodLbl.text = special.food
    }

}
