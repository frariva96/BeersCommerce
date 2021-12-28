//
//  Beer.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import Foundation

struct Beer: Codable {
    var id: Int
    var name: String
    var imageUrl: String
    var description: String
    var abv: String
    var ibu: String
    var firstBrewed: String
    var foodPairing: [String]
    var brewersTips: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case description
        case abv
        case ibu
        case firstBrewed = "first_brewed"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        description = try values.decode(String.self, forKey: .description)
        firstBrewed = try values.decode(String.self, forKey: .firstBrewed)
        foodPairing = try values.decode([String].self, forKey: .foodPairing)
        brewersTips = try values.decode(String.self, forKey: .brewersTips)
        
        if let abv = try values.decodeIfPresent(Double.self, forKey: .abv){
            self.abv = String(format: "%.f", abv)
        }else{
            self.abv = "N/A"
        }
        
        if let ibu = try values.decodeIfPresent(Double.self, forKey: .ibu){
            self.ibu = String(format: "%.f", ibu)
        }else{
            self.ibu = "N/A"
        }
    }
}
