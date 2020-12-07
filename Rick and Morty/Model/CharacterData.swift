//
//  Character.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

struct CharacterData: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String?
    
    var location: CharacterLocation?
    var origin: CharacterLocation?
    
    var episode: [String]
    
    var isAlive: Bool {
        return self.status.lowercased() != "dead"
    }
}
