//
//  CharacterDataSource.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterDataSource: NSObject {
    // MARK: - Variables
    var characterList: [CharacterData] = [CharacterData]()
    var cellForRow: ((IndexPath) -> CharacterTableViewCell?)!
        
    // MARK: - Funcs
    func getCharacter(index: Int) -> CharacterData? {
        guard index < self.characterList.count else { return nil }
        return self.characterList[index]
    }
    
    // MARK: - Initializers
    init(with characters: [CharacterData]) {
        super.init()        
        self.characterList = characters
    }
        
}

extension CharacterDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForRow = self.cellForRow else { return UITableViewCell() }
        let cell = cellForRow(indexPath)
        cell!.character = self.characterList[indexPath.row]
        return cell!
    }    
}

enum CellType {
    case Character
}
