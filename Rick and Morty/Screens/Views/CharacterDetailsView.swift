//
//  CharacterDetailsView.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 06/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterDetailsView: UIView, ViewCodeProtocol {
    // MARK: - Variables
    let cellIdenfier = "episodeCell"
    
    var character: CharacterData! {
        didSet {
            DispatchQueue.main.async {
                self.characterDetailsLabel.text = self.character.gender + " / " + self.character.species + " / " + self.character.status
                if let avatarURL = URL(string: self.character.image ?? "") {
                    self.characterAvatar.loadImage(from: avatarURL)
                }
                
                self.setDataSource(episodes: self.character.episode)
            }
        }
    }

    var tableViewDataSource: EpisodeDataSource! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View Hierarchy
    private lazy var tableView: UITableView = {
        let tableView = UIBuilderHelper.shared.buildTableView(style: .grouped)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = 60.0
        return tableView
    }()
    
    private lazy var headerTableView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 300))
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var characterDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var characterDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var characterAvatar: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - View Protocol
    func buildHierarchy() {
        self.addSubview(self.tableView)
        self.headerTableView.addSubview(self.characterAvatar)
        self.headerTableView.addSubview(self.characterDetailsView)
        self.characterDetailsView.addSubview(self.characterDetailsLabel)
        self.tableView.tableHeaderView = self.headerTableView
    }
    
    func setupConstraints() {
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.characterAvatar.widthAnchor.constraint(equalTo: self.headerTableView.widthAnchor, multiplier: 1).isActive = true
        self.characterAvatar.heightAnchor.constraint(equalTo: self.headerTableView.heightAnchor, multiplier: 1).isActive = true
        
        self.characterDetailsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.characterDetailsView.leadingAnchor.constraint(equalTo: self.headerTableView.leadingAnchor).isActive = true
        self.characterDetailsView.trailingAnchor.constraint(equalTo: self.headerTableView.trailingAnchor).isActive = true
        self.characterDetailsView.bottomAnchor.constraint(equalTo: self.headerTableView.bottomAnchor).isActive = true
        
        self.characterDetailsLabel.leadingAnchor.constraint(equalTo: self.headerTableView.leadingAnchor, constant: 8).isActive = true
        self.characterDetailsLabel.trailingAnchor.constraint(equalTo: self.headerTableView.trailingAnchor, constant: 8).isActive = true
        self.characterDetailsLabel.centerYAnchor.constraint(equalTo: self.characterDetailsView.centerYAnchor).isActive = true
    }
    
    func additionalSetup() {
        self.presentCharacterDetails()
        self.tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: self.cellIdenfier)
        self.tableView.dataSource = self.tableViewDataSource
    }
    
    // MARK: - Funcs
    func setDataSource(episodes: [String]) {
        DispatchQueue.main.async {
            self.tableViewDataSource = EpisodeDataSource(episodes: episodes)
            self.tableViewDataSource.cellForRow = { (indexPath) in
                let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdenfier, for: indexPath) as! EpisodeTableViewCell
                return cell
            }
            self.tableView.dataSource = self.tableViewDataSource
        }
    }
    
    func presentCharacterDetails() {
        self.characterDetailsView.transform = self.characterDetailsView.transform.translatedBy(x: 0, y: 50)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       options: [.curveEaseOut],
                       animations: {
                        self.characterDetailsView.transform = .identity
                        })
    }
    
    // MARK: - Overrides
    convenience init(character: CharacterData) {
        self.init()
        self.character = character
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
