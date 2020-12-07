//
//  UIBuilderHelper.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 06/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class UIBuilderHelper: NSObject {

    // MARK: - Singleton
    public static let shared = UIBuilderHelper()
    
    func buildTableView(style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }
    
    func buildFavoriteButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = UIImage(named: "Assets/Icons/icNotFavoriteCharacter")
        return buttonItem
    }
    
    func buildUnfavoriteButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = UIImage(named: "Assets/Icons/icFavoriteCharacter")
        return buttonItem
    }
    
    func buildFavoriteListButton() -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem()
        buttonItem.image = UIImage(named: "Assets/Icons/icFavoriteCharacter")
        return buttonItem
    }
    
    func buildActivityIndicatorButton() -> UIBarButtonItem {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        let buttonItem = UIBarButtonItem(customView: activityIndicator)
        return buttonItem
    }
    
}
