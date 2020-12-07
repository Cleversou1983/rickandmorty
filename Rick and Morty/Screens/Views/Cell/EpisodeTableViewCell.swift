//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell, ViewCodeProtocol {
    var safeArea: UILayoutGuide!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
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
    
    func buildHierarchy() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    func setupConstraints() {
        self.safeArea = self.layoutMarginsGuide
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        
    }
    
    func additionalSetup() {
        self.selectionStyle = .none
    }
    
    // MARK: - Variables
    var episodeURL: String! {
        didSet {
            self.loadingState()
            APIService.shared.getEpisode(episodeURL: self.episodeURL) { (episode) in
                if let episode = episode {
                    self.episode = episode
                }
                
                self.idleState()
            }
        }
    }
    
    var episode: Episode! {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - Funcs
    private func updateUI() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.episode.name
            self.descriptionLabel.text = self.episode.episode
        }
    }
        
    private func loadingState() {
        DispatchQueue.main.async {
            self.addSubview(self.activityIndicator)
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
    
    private func idleState() {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
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
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
    }
        
}
