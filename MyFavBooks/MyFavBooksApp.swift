//
//  MyFavBooksApp.swift
//  MyFavBooks
//
//  Created by AM Student on 9/26/24.
//

import SwiftUI

@main
struct MyFavBooksApp: App {
    
    @StateObject private var library = Library()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(library)
        }
    }
}
