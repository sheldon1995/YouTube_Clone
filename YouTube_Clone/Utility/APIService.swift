//
//  APIService.swift
//  YouTube_Clone
//
//  Created by Sheldon on 5/9/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class APIService{
    static let shared = APIService()
    
    
    func fetchVideos(withType type : String, completion : @escaping([Video])->()){
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/\(type).json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
 
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                
                // Because the resource json file using name like thumbnail_image_name, it it snake style.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let videos = try decoder.decode([Video].self, from: data)
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
}
