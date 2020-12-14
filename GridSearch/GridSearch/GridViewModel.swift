//
//  GridViewModel.swift
//  GridSearch
//
//  Created by Nipun Garg on 12/13/20.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var items = 0..<10
    @Published var appsData = [AppData]()
    
    init() {
        let jsonURLString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
        
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                print(rss)
                DispatchQueue.main.async {
                    self.appsData = rss.feed.results
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
}
