//
//  APIService.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import Foundation

class APIService {
    
    // Funzione per recuperare tramite API i dati delle birre
    func getData() -> [Beer]{
        
        let url = "https://api.punkapi.com/v2/beers"
        
        var beers: [Beer] = []
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                beers = try! JSONDecoder().decode([Beer].self, from: data)
            }
        }
        return beers
    }
}
