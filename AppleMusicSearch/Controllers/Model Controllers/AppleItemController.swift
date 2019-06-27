//
//  AppleItemController.swift
//  AppleMusicSearch
//
//  Created by Darin Marcus Armstrong on 6/27/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class AppleItemController {
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func fetchAppleItemFor(term: String, completion: @escaping ([AppleItem]?) -> Void) {
        guard var url = baseURL else {completion(nil); return}
        
        url.appendPathComponent("search")
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {completion(nil); return}
        let searchTermQuery  = URLQueryItem(name: "term", value: term)
        let mediaQuery = URLQueryItem(name: "media", value: "music")
        components.queryItems = [searchTermQuery, mediaQuery]
        
        guard let finalURL = components.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil); return
            }
            
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                completion(topLevelJSON.results)
                
            }catch {
                print(error.localizedDescription)
                completion(nil); return
            }
        }.resume()
    }
    
    static func fetchImageFor(appleItem: AppleItem, completion: @escaping (UIImage?) -> Void) {
        let url = appleItem.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil); return
            }
            
            guard let data = data else {
                print("something went wrong")
                completion(nil); return
                
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
        
    }
}
