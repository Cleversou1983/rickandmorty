//
//  APIService.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class APIService: NSObject {

    public static let shared: APIService = APIService()
    
    func getAllCharacters(completion: @escaping (CharacterList?) -> Void) {
        let characterURL = URL(string: Constants.characterListURL)!

        let task = URLSession.shared.dataTask(with: characterURL) { (data, response, error) in
            guard error == nil && data != nil else { return }
            
            if let list: CharacterList = self.tryDecode(with: data!) {
                completion(list)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getCharacter(characterID: Int, completion: @escaping ((CharacterData?) -> Void)) {
        let characterURL = URL(string: "\(Constants.characterDetails)\(characterID)")!
        
        let task = URLSession.shared.dataTask(with: characterURL) { (data, response, error) in
            guard error == nil && data != nil else { return }
            
            if let character: CharacterData = self.tryDecode(with: data!) {
                completion(character)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getEpisode(episodeURL: String, completion: @escaping ((Episode?) -> Void)) {
        let episodeURL = URL(string: episodeURL)!
        
        let task = URLSession.shared.dataTask(with: episodeURL) { (data, response, error) in
            guard error == nil, data != nil else { return }
            
            if let episode: Episode = self.tryDecode(with: data!) {
                completion(episode)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    private func tryDecode<T: Decodable>(with data: Data) -> T? {
        if let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        
        return nil
    }
    
}
