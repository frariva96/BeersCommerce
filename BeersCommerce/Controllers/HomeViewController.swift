//
//  HomeViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    var beerlistFirebase: DatabaseReference = Database.database().reference().child("beerlist")

    var beerViewModel: BeersViewModel!

    @IBOutlet weak var searchBarBeer: UISearchBar!
    @IBOutlet weak var beerTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerTable.delegate = self
        beerTable.dataSource = self
        searchBarBeer.delegate = self
        
        loadBeersData()
        
        login()
        
        /*beerlistFirebase.observe(.value) { snapshot in
            
            for item in snapshot.children {
                let beerData = item as! DataSnapshot
                
                let beer = beerData.value as! [String: Any]
                
                print(beer["year"]!)
                
            }
            
        }*/
        
        for beer in beersList {
            beerlistFirebase.child(beer.name).updateChildValues(
                ["id": beer.id, "name": beer.name, "imageUrl": beer.imageUrl, "description": beer.description, "abv": beer.abv, "ibu": beer.ibu, "firstBrewed": beer.firstBrewed, "foodPairing": beer.foodPairing, "brewersTips": beer.brewersTips])
        }
        
    }
    
    func login () {
        Auth.auth().signInAnonymously { User, Error in
            if let error = Error {
                print(error)
            }else{
                if let user = User {
                    print(user.user.uid)
                }
            }
        }
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
        
        cell.idBeerLabel.text = String(beersList[indexPath.row].id)
        
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "homeTObeerInfo" else {
            return
        }
        
        let vc = segue.destination as! BeerInfoViewController
        let beer = sender as! Beer
        vc.beer = beer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBarBeer.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        searchBarBeer.setShowsCancelButton(false, animated: true)
        
        performSegue(withIdentifier: "homeTObeerInfo", sender: beersList[indexPath.row])
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBarBeer.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarBeer.text = ""
        beerTable.reloadData()
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
            beersList = beersList.filter({ (word: Beer) -> Bool in
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
            loadBeersData()
        }
        self.beerTable.reloadData()
    }
    
    
    
    
    @IBAction func cartAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "homeTOcart", sender: nil)
    }
    
}
