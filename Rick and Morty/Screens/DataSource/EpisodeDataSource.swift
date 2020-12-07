//
//  EpisodeDataSpirce.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 07/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class EpisodeDataSource: NSObject {
    // MARK: - Variables
    var episodes: [String] = [String]()
    var cellForRow: ((IndexPath) -> EpisodeTableViewCell?)!
    
    // MARK: - Override
    init(episodes: [String]) {
        super.init()
        self.episodes = episodes
    }
    
}

extension EpisodeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cellForRow(indexPath)!
        cell.episodeURL = self.episodes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episodes"
    }
}
