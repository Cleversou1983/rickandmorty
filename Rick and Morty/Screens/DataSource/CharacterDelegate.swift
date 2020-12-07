//
//  CharacterDelegate.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class CharacterDelegate: NSObject {
    var didSelectRow: ((IndexPath) -> Void)?
    
    // MARK: - Funcs
    func animateSelection(tableView: UITableView, indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.backgroundColor = .opaqueSeparator
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut], animations: {
                        cell.transform = cell.transform.translatedBy(x: 44, y: 0)
                        cell.backgroundColor = .white
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                cell.transform = .identity
            }
            self.didSelectRow?(indexPath)
        }
    }
    
    // MARK: - Overrides
    override init() {
        super.init()
    }
}

extension CharacterDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.animateSelection(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = cell.transform.translatedBy(x: -44, y: 0)
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.4 * (Double(indexPath.row) * 0.02),
                       options: [.curveEaseOut],
                       animations: {
                        cell.transform = .identity
                        cell.alpha = 1.0
        }, completion: nil)
    }
    
}
