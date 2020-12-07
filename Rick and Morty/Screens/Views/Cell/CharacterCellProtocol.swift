//
//  CharacterTableViewProtocol.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

protocol CharacterCellProtocol: UITableViewCell {
    var character: CharacterData! {
        get set
    }
}
