//
//  ViewController.swift
//  tiny-tabs
//
//  Created by Adam Goth on 10/12/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var neighborhoodButton: UIButton!
    
    var specials = [Special]()
    var filteredSpecials = [Special]()
    var restaurants = [Restaurant]()
    var filteredRestaurants = [String]()
    var neighborhoods = [Neighborhood]()
    
    var day = "All"
    var hood: Neighborhood? = nil
    
    var filteredResults: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                
                if let neighborhoodResults = data["neighborhoods"] as? [String: AnyObject] {
                    for neighborhoodResult in neighborhoodResults {
                        let id = neighborhoodResult.key
                        let name = neighborhoodResult.value["name"] as! String
                        let neighborhood = Neighborhood(id: id, name: name)
                        self.neighborhoods.append(neighborhood)
                    }
                }
                
                if let restaurantResults = data["restaurants"] as? [String: AnyObject] {
                    for restaurantResult in restaurantResults {
                        let id = restaurantResult.key
                        let dict = restaurantResult.value
                        let restaurant = Restaurant(id: id, dict: dict as! [String : String])
                        self.restaurants.append(restaurant)
                    }
                }
                
                if let specialResults = data["specials"] as? [String: AnyObject] {
                    for specialResult in specialResults {
                        if let specialDict = specialResult.value as? [String: AnyObject] {
                            let restaurantId = specialDict["restaurantId"] as! String
                            let time = specialDict["description"]!["time"] as! String
                            let drink = specialDict["description"]!["drink"] as! String
                            let food = specialDict["description"]!["food"] as! String
                            let days = specialDict["days"] as! [String: Bool]
                            let special = Special(restaurantId: restaurantId, time: time, drink: drink, food: food, days: days)
                            self.specials.append(special)
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredResults == true {
            return filteredSpecials.count
        } else {
            return specials.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var special: Special!
        
        if filteredResults == true {
            special = filteredSpecials[indexPath.row]
        } else {
            special = specials[indexPath.row]
        }
        
        let filterRestaurant = restaurants.filter { $0.id == special.restaurantId }.first!
        let filterNeighborhood = neighborhoods.filter { $0.id == filterRestaurant.neighborhood }.first!
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCell") as? SpecialCell {
            cell.configureCell(special: special, restaurant: filterRestaurant, neighborhood: filterNeighborhood)
            return cell
        } else {
            return SpecialCell()
        }
    }
    
    func filterResults(day: String, neighborhood: Neighborhood?) {
        filteredResults = true
        filteredSpecials = specials
        
        if neighborhood != nil {
            filteredRestaurants.removeAll()
            for restaurant in restaurants {
                if restaurant.neighborhood == neighborhood!.id {
                    filteredRestaurants.append(restaurant.id)
                }
            }
            filteredSpecials = specials.filter { filteredRestaurants.contains($0.restaurantId) }
        }
        
        if day != "All" {
            filteredSpecials = filteredSpecials.filter { $0.days["\(day)"] == true }
        }
        
        tableView.reloadData()
    }
    
    func setDay(action: UIAlertAction!) {
        dayButton.setTitle(action.title!, for: .normal)
        if action.title! != "All" {
            day = action.title!
        } else {
            day = "All"
        }
        filterResults(day: day, neighborhood: hood)
    }
    
    func setNeighborhood(action: UIAlertAction!, neighborhood: Neighborhood?) {
        neighborhoodButton.setTitle(action.title, for: .normal)
        if neighborhood != nil {
            hood = neighborhood
        } else {
            hood = nil
        }
        filterResults(day: day, neighborhood: hood)
    }
    
    @IBAction func dayTapped(_ sender: AnyObject) {
        let ac = UIAlertController(title: "Select Day", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "All", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Monday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Tuesday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Wednesday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Thursday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Friday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Saturday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Sunday", style: .default, handler: setDay))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    @IBAction func neighborhoodTapped(_ sender: AnyObject) {
        let ac = UIAlertController(title: "Select Neighborhood", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "All", style: .default, handler: { (action: UIAlertAction!) in self.setNeighborhood(action: action, neighborhood: nil) }))
        for neighborhood in neighborhoods {
            ac.addAction(UIAlertAction(title: "\(neighborhood.name)", style: .default, handler: { (action: UIAlertAction!) in self.setNeighborhood(action: action, neighborhood: neighborhood) }))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

}

