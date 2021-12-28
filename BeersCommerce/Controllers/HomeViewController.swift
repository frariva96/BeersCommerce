//
//  HomeViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    var beerViewModel: BeersViewModel!

    @IBOutlet weak var searchBarBeer: UISearchBar!
    @IBOutlet weak var beerTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerTable.delegate = self
        beerTable.dataSource = self
        
        loadBeersData()
    }
    
    func loadBeersData () {
        beerViewModel = BeersViewModel()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        
        cell.textLabel?.text = beersList[indexPath.row].name
        
        return cell
    }

   
}
