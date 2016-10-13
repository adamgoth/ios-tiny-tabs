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
    
    var specials = [Special]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.specials_ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if let specialResults = snapshot.value as? [String: AnyObject] {
                for specialResult in specialResults {
                    print(specialResult)
                    if let specialDict = specialResult.value as? [String: AnyObject] {
                        let restaurantId = specialDict["restaurantId"] as! String
                        let description = specialDict["description"] as! String
                        let days = specialDict["days"] as! [String: Bool]
                        let special = Special(restaurantId: restaurantId, description: description, days: days)
                        self.specials.append(special)
                    }
                    
                }
                
            print("specials: \(self.specials.count)")
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCell") as? SpecialCell {
            cell.configureCell(special: special)
            return cell
        } else {
            return SpecialCell()
        }
    }


}

