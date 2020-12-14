//
//  ContentView.swift
//  GridSearch
//
//  Created by Nipun Garg on 12/12/20.
//

import SwiftUI
import KingfisherSwiftUI

struct ContentView: View {
    @ObservedObject var vm = GridViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchView(searchText: $searchText, isSearching: $isSearching)
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top),
                    GridItem(.flexible(minimum: 50, maximum: 200), spacing: 16, alignment: .top)
                ], alignment: .leading, spacing: 16, content: {
                    ForEach(vm.appsData, id: \.self) { appData in
                        
                        if (appData.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty) {
                            AppInfo(appData: appData)
                        }
                    }
                })
                .padding(.horizontal, 12)
            }
            .navigationBarTitle(Text("Grid Search"))
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
