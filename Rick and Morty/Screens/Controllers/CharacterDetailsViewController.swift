//
//  CharacterDetailsViewController.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 06/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    // MARK: - Variables
    let screen = CharacterDetailsView()
    var character: CharacterData!
    
    // MARK: - Funcs
    private func loadCharacter(withID id: Int) {
        APIService.shared.getCharacter(characterID: id) { (character) in
            guard let character = character else {
                return
            }
            
            self.setCharacter(with: character)
        }
    }
    
    private func setCharacter(with character: CharacterData) {
        self.character = character
        self.screen.character = self.character
    }
    
    private func showAddFavoriteButton() {
        let button = UIBuilderHelper.shared.buildFavoriteButton()
        button.target = self
        button.action = #selector(addToFavorites)
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func showRemoveFavoriteButton() {
        let button = UIBuilderHelper.shared.buildUnfavoriteButton()
        button.target = self
        button.action = #selector(removeFromFavorites)
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func handleFavoriteButton() {
        FavoriteCharacterService.shared.isFavoriteCharacter(widthID: self.character.id) ?
            self.showRemoveFavoriteButton() :
            self.showAddFavoriteButton()
    }
    
    @objc
    private func addToFavorites() {
        FavoriteCharacterService.shared.addFavoriteCharacter(withID: self.character.id)
        self.showRemoveFavoriteButton()
    }
    
    @objc
    private func removeFromFavorites() {
        FavoriteCharacterService.shared.removeFavoriteCharacter(withID: self.character.id)
        NotificationCenter.default.post(name: .DidUnfavoriteCharacter, object: nil, userInfo: ["characterID": self.character.id])
        self.showAddFavoriteButton()
    }
    
    // MARK: - Overrides
    convenience init(character: CharacterData) {
        self.init()
        self.setCharacter(with: character)
    }
    
    override func loadView() {
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.character.name
        
        self.loadCharacter(withID: self.character.id)
        self.handleFavoriteButton()
    }


}
