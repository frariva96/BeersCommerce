//
//  HomeViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit
import Firebase

var beerListDatabase: [BeerFromDatabase] = []
var userGlobal: String?
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    var cartItemTabBar: UITabBarItem?
    var user: String? = "NhoqolKV5lfcEGRSasV7PEpZL862"
    
    @IBOutlet weak var searchBarBeer: UISearchBar!
    @IBOutlet weak var beerTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = false

        userGlobal = user
        beerTable.delegate = self
        beerTable.dataSource = self
        searchBarBeer.delegate = self
        //navigationController?.navigationBar.isHidden = true
        
        loadDataFromDatabase()
        cartItemTabBar = tabBarController?.tabBar.items![1]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func loadDataFromDatabase() {
        userCart = Database.database().reference().child("cartUser").child(user!)
        
        userCart?.observe(.value) { snapshot in
            
            beerListDatabase = []
            tot = 0
            
            for item in snapshot.children {
                
                let beerData = item as! DataSnapshot
                let beer = beerData.value as! [String: Any]
                
                tot! += beer["quantity"] as! Int
                
                beerListDatabase.append(BeerFromDatabase(
                    id: beer["id"] as! Int,
                    name: beer["name"] as! String,
                    imageUrl: beer["imageUrl"] as! String,
                    description: beer["description"] as! String,
                    abv: beer["abv"] as! String,
                    ibu: beer["ibu"] as! String,
                    firstBrewed: beer["firstBrewed"] as! String,
                    foodPairing: beer["foodPairing"] as! [String],
                    brewersTips: beer["brewersTips"] as! String,
                    quantity: beer["quantity"] as! Int)
                )
            }
            self.cartItemTabBar?.badgeValue = String(tot!)
            self.beerTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerListDatabase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        
        cell.beerTitle.text = beerListDatabase[indexPath.row].name
        cell.beerDescription.text = beerListDatabase[indexPath.row].description
        cell.beerAbv.text = beerListDatabase[indexPath.row].abv + "% VOL."
        cell.beerIbu.text = beerListDatabase[indexPath.row].ibu
        cell.cartQuantityLabel.text = String(beerListDatabase[indexPath.row].quantity)
        
        // caricamento asincrono delle immagini
       if let url = NSURL(string: beerListDatabase[indexPath.row].imageUrl) {
            DispatchQueue.global(qos: .default).async{
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        cell.beerImage.image = UIImage(data: data as Data)
                    }
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "homeTObeerInfo" else {
            return
        }
        
        let vc = segue.destination as! BeerInfoViewController
        let beer = sender as! BeerFromDatabase
        vc.beer = beer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBarBeer.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        searchBarBeer.setShowsCancelButton(false, animated: true)
        
        performSegue(withIdentifier: "homeTObeerInfo", sender: beerListDatabase[indexPath.row])
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBarBeer.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarBeer.text = ""
        loadDataFromDatabase()
        searchBarBeer.setShowsCancelButton(false, animated: true)
        searchBarBeer.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarBeer.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBarBeer.endEditing(true)
    }
    
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchBarBeer.text!.isEmpty {
            beerListDatabase = beerListDatabase.filter({ (word: BeerFromDatabase) -> Bool in
                let result: Range<String.Index>?
                let filterName = word.name.range(of: searchBarBeer.text!)
                let filterDescription = word.description.range(of: searchBarBeer.text!)
                
                if filterName != nil {
                    result = filterName
                } else {
                    result = filterDescription
                }
                return result != nil
            })
        }else{
            loadDataFromDatabase()
        }
        self.beerTable.reloadData()
    }
    
    @IBAction func cartAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "homeTOcart", sender: nil)
    }
}
