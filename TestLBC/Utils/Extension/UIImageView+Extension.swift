//
//  UIImageView+Extension.swift
//  TestLBC
//
//  Created by Jordane HUY on 24/06/2022.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadRemoteImageFrom(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    } else {
                        self.image = UIImage(systemName: "photo.circle")
                        self.tintColor = .gray
                    }
                }
            }
        }.resume()
    }
}
