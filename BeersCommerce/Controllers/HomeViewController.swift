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
    @IBOutlet weak var cartTabBar: UITabBarItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerTable.delegate = self
        beerTable.dataSource = self
        
        loadBeersData()
        
        cartTabBar.badgeValue = cartQuantity
    }
    
    func loadBeersData () {
        beerViewModel = BeersViewModel()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        
        cell.beerTitle.text = beersList[indexPath.row].name
        cell.beerDescription.text = beersList[indexPath.row].description
        cell.beerAbv.text = beersList[indexPath.row].abv + "% VOL."
        cell.beerIbu.text = beersList[indexPath.row].ibu
        
        
        
        // caricamento asincrono delle immagini
       if let url = NSURL(string: beersList[indexPath.row].imageUrl) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "homeTObeerInfo", sender: beersList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "homeTObeerInfo" else {
            return
        }
        
        let vc = segue.destination as! BeerInfoViewController
        
        let beer = sender as! Beer
        
        vc.beer = beer
        
        
    
    }
    
}
