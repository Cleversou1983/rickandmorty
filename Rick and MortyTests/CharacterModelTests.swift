//
//  CharacterModelTests.swift
//  Rick and MortyTests
//
//  Created by Cleverson Luiz Correia de Souza on 06/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import XCTest
@testable import Rick_and_Morty

class CharacterModelTests: XCTestCase {
    // MARK: - Tests
    func testIsAlive() {
        let character = CharacterBuilder.shared.getCharacterWith(id: 1)!
        XCTAssertTrue(character.isAlive)
    }
    
    func testIsNotAlive() {
        let character = CharacterBuilder.shared.getCharacterWith(id: 484)!
        XCTAssertFalse(character.isAlive)
    }
    
    // MARK: - Overrides
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
