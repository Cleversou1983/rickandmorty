//
//  AsyncImageView.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 05/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class AsyncImageView: UIImageView {
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    var task: URLSessionDataTask!
    
    func loadImage(from url: URL) {
        self.image = nil
        self.alpha = 0
        
        if let task = self.task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.setImage(image: imageFromCache)
            return
        }
        
        DispatchQueue.main.async {
            self.loadingState()
        }
        
        self.task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard error == nil, let data = data, let newImage = UIImage(data: data) else  {
                print("Couldn't load the imageFile")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.idleState()
                self.setImage(image: newImage)
            }
        })
        
        self.task.resume()
    }

    private func setImage(image: UIImage) {
        self.image = image
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    private func loadingState() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func idleState() {
        self.activityIndicator.removeFromSuperview()
    }
    
}
