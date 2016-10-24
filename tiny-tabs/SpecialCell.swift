//
//  SpecialCell.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/12/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class SpecialCell: UITableViewCell {
    
    @IBOutlet weak var timeImg: UIImageView!
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var foodImg: UIImageView!
    
    @IBOutlet weak var restaurantLbl: UILabel!
    @IBOutlet weak var neighborhoodLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var drinkLbl: UILabel!
    @IBOutlet weak var foodLbl: UILabel!
    
    var special: Special!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(special: Special, restaurant: Restaurant, neighborhood: Neighborhood) {
        self.special = special
        restaurantLbl.text = restaurant.name
        neighborhoodLbl.text = neighborhood.name
        addressLbl.text = restaurant.address1
        if special.time == "" {
            timeImg.isHidden = true
            timeLbl.isHidden = true
        } else {
            timeImg.isHidden = false
            timeLbl.isHidden = false
            timeLbl.text = special.time
        }
        if special.drink == "" {
            drinkImg.isHidden = true
            drinkLbl.isHidden = true
        } else {
            drinkImg.isHidden = false
            drinkLbl.isHidden = false
            drinkLbl.text = special.drink
        }
        if special.food == "" {
            foodImg.isHidden = true
            foodLbl.isHidden = true
        } else {
            foodImg.isHidden = false
            foodLbl.isHidden = false
            foodLbl.text = special.food
        }
    }

}
