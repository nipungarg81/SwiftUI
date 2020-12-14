//
//  ContentView.swift
//  SearchBarSwithUI
//
//  Created by Nipun Garg on 12/13/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                SearchView(searchText: $searchText, isSearching: $isSearching)
                
                ForEach((0..<20).filter({ "\($0)".contains(searchText) || searchText.isEmpty }), id: \.self) { num in
                    HStack {
                        Text("\(num)")
                        Spacer()
                    }.padding()
                    Divider()
                }
            }
            .navigationTitle("Food")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .colorScheme(.dark)
    }
}

struct SearchView: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search terem here", text:$searchText)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray4))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName:"magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: { searchText = ""}, label: {
                            Image(systemName:"xmark.circle.fill")
                                .padding(.vertical)
                            
                        })
                        
                    }
                    
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
                
            }
        }
    }
}
