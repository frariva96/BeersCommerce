//
//  BeersViewModel.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import Foundation

// Variabile globale con l'elenco delle birre e rispettivi dati
var beersList: [Beer] = []

class BeersViewModel {
    
    private var apiService: APIService!
    
    init() {
        self.apiService = APIService()
        self.callFuncToGetBeersData()
    }
    
    // Funzione per recuperare i dati delle birre
    func callFuncToGetBeersData() {
        beersList = self.apiService.getData()
    }
}
