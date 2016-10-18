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
    var restaurants = [Restaurant]()
    var neighborhoods = [Neighborhood]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.restaurants_ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if let restaurantResults = snapshot.value as? [String: AnyObject] {
                for restaurantResult in restaurantResults {
                    let id = restaurantResult.key
                    let dict = restaurantResult.value
                    let restaurant = Restaurant(id: id, dict: dict as! [String : String])
                    self.restaurants.append(restaurant)
                }
            }
        })
        
        DataService.ds.neighborhoods_ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if let neighborhoodResults = snapshot.value as? [String: AnyObject] {
                for neighborhoodResult in neighborhoodResults {
                    let id = neighborhoodResult.key
                    let name = neighborhoodResult.value["name"] as! String
                    let neighborhood = Neighborhood(id: id, name: name)
                    self.neighborhoods.append(neighborhood)
                }
            }
        })
    
        DataService.ds.specials_ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if let specialResults = snapshot.value as? [String: AnyObject] {
                for specialResult in specialResults {
                    if let specialDict = specialResult.value as? [String: AnyObject] {
                        let restaurantId = specialDict["restaurantId"] as! String
                        let description = specialDict["description"] as! String
                        let days = specialDict["days"] as! [String: Bool]
                        let special = Special(restaurantId: restaurantId, description: description, days: days)
                        self.specials.append(special)
                    }
                }
                
            self.tableView.reloadData()
            }
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
        return specials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let special = specials[indexPath.row]
        let filterRestaurant = restaurants.filter { $0.id == special.restaurantId }
        let restaurant = filterRestaurant[0]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCell") as? SpecialCell {
            cell.configureCell(special: special, restaurant: restaurant)
            return cell
        } else {
            return SpecialCell()
        }
    }
    
    func setDay(action: UIAlertAction!) {
        
    }
    
    func setNeighborhood(action: UIAlertAction!) {
        
    }
    
    @IBAction func dayTapped(_ sender: AnyObject) {
        let ac = UIAlertController(title: "Select Day", message: nil, preferredStyle: .actionSheet)
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
        for neighborhood in neighborhoods {
            ac.addAction(UIAlertAction(title: "\(neighborhood.name)", style: .default, handler: setNeighborhood))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

}

