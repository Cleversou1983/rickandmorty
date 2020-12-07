//
//  FavoriteCharacterListViewController.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 07/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class FavoriteCharacterListViewController: UIViewController {
    // MARK: - Variables
    let screen = CharacterListView()
    var characterList: [CharacterData] = [CharacterData]()
    
    // MARK: - Funcs
    @objc
    func didUnfavoriteCharacter(notification: Notification) {
        if let id = notification.userInfo?["characterID"] as? Int {
            if let index = self.characterList.firstIndex(where: {$0.id == id}) {
                self.characterList.remove(at: index)
                self.screen.setDataSource(data: self.characterList)
            }
        }
    }
    
    // MARK: - Overrides
    convenience init(characterList: [CharacterData]) {
        self.init()
        self.characterList = characterList
        self.screen.setDataSource(data: self.characterList)
    }
    
    override func loadView() {
        self.view = screen
        self.screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorite Characters"
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUnfavoriteCharacter(notification:)), name: .DidUnfavoriteCharacter, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard FavoriteCharacterService.shared.getFavoriteCharactersIDs.count > 0 else {
            self.navigationController?.popViewController(animated: true)
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .DidUnfavoriteCharacter, object: nil)
    }
    
}

extension FavoriteCharacterListViewController: CharacterListViewDelegate {
    func didSelect(character: CharacterData) {
        let characterDetailsViewController = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
}
