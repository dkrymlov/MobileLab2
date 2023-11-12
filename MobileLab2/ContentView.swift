//
//  ContentView.swift
//  MobileLab2
//
//  Created by Даниил Крымлов on 12.11.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            StudentView()
                .tabItem {
                    Image(systemName: "book.circle")
                    Text("Students")
                }
            Contacts()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Contacts")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            Author()
                .tabItem {
                    Image(systemName: "person.fill.checkmark")
                    Text("Author")
                }
        }
        
    }
    
}

#Preview {
    ContentView()
}
