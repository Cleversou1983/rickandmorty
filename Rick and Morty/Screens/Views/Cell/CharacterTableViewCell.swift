//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, CharacterCellProtocol, ViewCodeProtocol {
    var safeArea: UILayoutGuide!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(13.0)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var avatar: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
       
    
    func buildHierarchy() {
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    func setupConstraints() {
        self.safeArea = self.layoutMarginsGuide
        self.avatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.avatar.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor).isActive = true
                
        let avatarBottomConstraint = self.avatar.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        avatarBottomConstraint.isActive = true
        avatarBottomConstraint.priority = .defaultLow
        
        self.avatar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatar.widthAnchor.constraint(equalTo: self.avatar.heightAnchor).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.avatar.topAnchor, constant: 8).isActive = true
        
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -8).isActive = true
    }
    
    func additionalSetup() {
        self.selectionStyle = .none
    }
    
    // MARK: - Variables
    var character: CharacterData! {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - Funcs
    private func updateUI() {
        self.titleLabel.text = self.character.name
        self.descriptionLabel.text = self.character.origin?.name
        
        if let url = URL(string: self.character.image ?? "") {
            self.avatar.loadImage(from: url)
        }

        if !self.character.isAlive {
            self.titleLabel.alpha = 0.5
            self.titleLabel.textColor = .red
            self.descriptionLabel.alpha = 0.5
            self.self.avatar.alpha = 0.5
        }
    }
    
    // MARK: - Overrides
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.alpha = 1
        self.titleLabel.textColor = .black
        self.descriptionLabel.alpha = 1
        self.avatar.alpha = 1
    }

}
