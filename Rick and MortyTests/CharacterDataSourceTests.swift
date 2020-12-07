//
//  CharacterDataSourceTests.swift
//  Rick and MortyTests
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import XCTest
@testable import Rick_and_Morty

class CharacterDataSourceTests: XCTestCase {
    // MARK: - Variables
    var dataSource: CharacterDataSource!
    
    func testTotalItensInList() {
        XCTAssertEqual(self.dataSource.characterList.count, 3)
    }

    func testGetCharacterRickSanchez() {
        let character = self.dataSource.getCharacter(index: 0)
        XCTAssertEqual(character?.id, 1)
    }
    
    func testGetCharacterMortySmith() {
        let character = self.dataSource.getCharacter(index: 1)
        XCTAssertEqual(character?.id, 2)
    }
    
    func testGetNilCharacter() {
        let character = self.dataSource.getCharacter(index: 3)
        XCTAssertNil(character)
    }
    
    func testGetNotNilCharacter() {
        let character = self.dataSource.getCharacter(index: 0)
        XCTAssertNotNil(character)
    }
    
    func testCellForRow() {
        let cell = self.cellForRow(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
        
    // MARK: - Funcs
    func cellForRow(indexPath: IndexPath) -> CharacterTableViewCell? {
        self.dataSource.cellForRow = { indexPath in
            if let character = self.dataSource.getCharacter(index: indexPath.row) {
                let cell = CharacterTableViewCell()
                cell.character = character
                return cell
            }
            return nil
        }
        
        let cell = self.dataSource.cellForRow(indexPath)
        return cell
    }
    
    // MARK: - Overrides
    override func setUpWithError() throws {
        self.dataSource = CharacterDataSource(with: CharacterBuilder.shared.characters)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
