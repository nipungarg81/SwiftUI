//
//  ContentView.swift
//  GridSearch
//
//  Created by Nipun Garg on 12/12/20.
//

import SwiftUI
import KingfisherSwiftUI

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [AppData]
}

struct AppData: Decodable, Hashable {
    let copyright, name, artworkUrl100, releaseDate: String
}

class GridViewModel: ObservableObject {
    @Published var items = 0..<10
    
    @Published var appsData = [AppData]()
    
    init() {
        let jsonURLString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
        
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

struct GridView: View {
    
    @ObservedObject var vm = GridViewModel()
        
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top)
                ], alignment: .leading, spacing: 16, content: {
                    ForEach(vm.appsData, id: \.self) { appData in
                        AppInfo(appData: appData)
                    }
                })
                .padding(.horizontal, 12)
            }
            .navigationBarTitle(Text("Grid Search"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}

struct AppInfo: View {
    let appData: AppData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: appData.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(22)
            Text(appData.name)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top, 4)
            Text(appData.releaseDate)
                .font(.system(size: 9, weight: .regular))
            Text(appData.copyright)
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}
