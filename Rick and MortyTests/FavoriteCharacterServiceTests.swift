//
//  FavoriteCharacterServiceTests.swift
//  Rick and MortyTests
//
//  Created by Cleverson Luiz Correia de Souza on 07/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import XCTest
@testable import Rick_and_Morty

class FavoriteCharacterServiceTests: XCTestCase {
    let testCharacterID: Int = 0
    
    // MARK: - Tests
    func testAddCharacterToFavorites() {
        let isFavorite = FavoriteCharacterService.shared.isFavoriteCharacter(widthID: testCharacterID)
        XCTAssertTrue(isFavorite)
    }
    
    func testRemoveCharacterFromFavorites() {
        FavoriteCharacterService.shared.removeFavoriteCharacter(withID: testCharacterID)
        let isFavorite = FavoriteCharacterService.shared.isFavoriteCharacter(widthID: testCharacterID)
        XCTAssertFalse(isFavorite)
    }
    
    // MARK: - Funcs
    func addFavorite() {
        FavoriteCharacterService.shared.addFavoriteCharacter(withID: testCharacterID)
    }
    
    // MARK: - Overrides
    override func setUpWithError() throws {
        self.addFavorite()
    }

    override func tearDownWithError() throws {
        FavoriteCharacterService.shared.removeFavoriteCharacter(withID: 0)
    }

}
