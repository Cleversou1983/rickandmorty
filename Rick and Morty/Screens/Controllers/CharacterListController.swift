//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterListController: UIViewController {
    // MARK: - Variables
    let screen = CharacterListView()
    
    // MARK: - Funcs
    private func loadCharacters() {
        self.navigationItem.rightBarButtonItem = UIBuilderHelper.shared.buildActivityIndicatorButton()
        APIService.shared.getAllCharacters { (list) in
            self.showFavoriteCharactersButton()
            if let characters = list?.results {
                self.screen.setDataSource(data: characters)
            }
        }
    }
    
    private func showFavoriteCharactersButton() {
        DispatchQueue.main.async {
            let button = UIBuilderHelper.shared.buildFavoriteListButton()
            button.target = self
            button.action = #selector(self.showFavoriteList)
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    @objc
    private func showFavoriteList() {
        guard FavoriteCharacterService.shared.getFavoriteCharactersIDs.count > 0  else {
            let alert = UIAlertController(title: "Favoritos", message: "Você não possui nenhum personagem salvo como favorito.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
    
        APIService.shared.getAllCharacters { (list) in
            if let characters = list?.results {
                let favoriteCharactersIDs = FavoriteCharacterService.shared.getFavoriteCharactersIDs
                var favoriteCharacters = [CharacterData]()
                favoriteCharactersIDs.forEach { id in
                    characters.filter({$0.id == id}).forEach({favoriteCharacters.append($0)})
                }
                
                self.presentFavoriteList(characters: favoriteCharacters)
            } else {
                return
            }
        }
        
    }
    
    private func presentFavoriteList(characters: [CharacterData]) {
        DispatchQueue.main.async {
            let favoriteListController = FavoriteCharacterListViewController(characterList: characters)
            self.navigationController?.pushViewController(favoriteListController, animated: true)
        }
    }
    
    // MARK: - Overrides
    override func loadView() {
        self.screen.delegate = self
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Characters"
        self.navigationItem.prompt = "Select a character"
        self.loadCharacters()
        self.showFavoriteCharactersButton()
    }

}

extension CharacterListController: CharacterListViewDelegate {
    func didSelect(character: CharacterData) {
        let characterDetailsViewControler = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(characterDetailsViewControler, animated: true)
    }
}
