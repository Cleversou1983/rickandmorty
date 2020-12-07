//
//  CharacterListView.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterListView: UIView, ViewCodeProtocol {
    // MARK: - Variables
    private var characterCellIdentifier = "characterCell"
    private var tableViewDelegate: CharacterDelegate!
    private var tableViewDataSource: CharacterDataSource! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var delegate: CharacterListViewDelegate?
            
    // MARK: - View Hierarchy
    private lazy var tableView: UITableView = {
        return UIBuilderHelper.shared.buildTableView()
    }()
    
    // MARK: - View Protocol
    func buildHierarchy() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func additionalSetup() {
        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: self.characterCellIdentifier)
        self.tableViewDelegate = CharacterDelegate()
        self.tableViewDelegate.didSelectRow = { indexPath in
            let character = self.tableViewDataSource.getCharacter(index: indexPath.row)
            self.delegate?.didSelect(character: character!)
        }
        self.tableView.delegate = self.tableViewDelegate
    }
    
    // MARK: - Funcs
    public func setDataSource(data: [CharacterData]) {
        DispatchQueue.main.async {
            self.tableViewDataSource = CharacterDataSource(with: data)
            self.tableViewDataSource.cellForRow = { (indexPath) in
                let cell = self.tableView.dequeueReusableCell(withIdentifier: self.characterCellIdentifier, for: indexPath) as! CharacterTableViewCell
                return cell
            }
            self.tableView.dataSource = self.tableViewDataSource
        }
    }
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol CharacterListViewDelegate {
    func didSelect(character: CharacterData)
}
