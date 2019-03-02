//
//  TableViewController.swift
//  JSON Table Viewer
//
//  Created by Rob Weiss on 3/2/19.
//  Copyright © 2019 Rob Weiss. All rights reserved.
//

import UIKit

struct Superheros: Decodable {
    let heroName: String
    let name: String
}

class TableViewController: UITableViewController {
    
    var superheroArray = [Superheros]()
    
    let jsonDataURL = "http://patrickhill.nyc/justiceleague.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loads JSON and stores in array
        let url = URL(string: jsonDataURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.superheroArray = try JSONDecoder().decode([Superheros].self, from: data!)
            } catch let jsonError {
                print ("An error occurred", jsonError)
            }
            OperationQueue.main.addOperation ({
                // Reloads the table data after the JSON has been retrieved
                self.tableView.reloadData()
            })
        }.resume()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = superheroArray[indexPath.row].heroName
        
        cell.detailTextLabel?.text = superheroArray[indexPath.row].name

        return cell
    }

}
