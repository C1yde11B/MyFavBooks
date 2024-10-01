//
//  Library.swift
//  MyFavBooks
//
//  Created by AM Student on 9/30/24.
//

import SwiftUI
import Combine
 
class Library: ObservableObject {
    
    
    var sortedBooks: [Section: [Book]] {
        //orgonizes books into sections based on their properties
        get {
            let groupedBooks = Dictionary(grouping: booksCache, by: \.myFavoriteBook)
            //map grouped book to sections and return as a dictionary
             return Dictionary(uniqueKeysWithValues: groupedBooks.map {
                 //uses a ternary operator (one code is true, one is false) to maps keys to correspinding section types.
                (($0.key ? .myFavoriteBooks : .finished),  $0.value)
            })
        } set {
            booksCache =
            newValue
                .sorted { $1.key == .finished }
                .flatMap { $0.value }
        }
    }
    //sorts books and updates bookcache
    func sortBooks() {
        booksCache =
        sortedBooks
            .sorted { $1.key == .finished }
            .flatMap { $0.value }
        
        objectWillChange.send()
    }
    //adds new book.
    func addNewBook (_ book: Book, image: Image?) {
        booksCache.insert(book, at: 0)
        images[book] = image
    }
    
    func deleteBooks(atOffSets offsets: IndexSet, section: Section) {
        let booksBeforeDeletion = booksCache
        
        sortedBooks[section]?.remove(atOffsets: offsets)
        
        for change in booksCache.difference(from: booksBeforeDeletion) {
            if case .remove(_, let deletedBook, _) = change {
                images[deletedBook] = nil
            }
        }
    }
    
    func moveBooks(oldOffSets: IndexSet, newOffSet: Int, section: Section) {
        sortedBooks[section]?.move(fromOffsets: oldOffSets, toOffset: newOffSet)
    }
    
    @Published private var booksCache: [Book] = [
        .init(title:"Gravity And Divinity System", author: "Hunter Mythos"),
                .init(title: "tokyo ghoul", author: "Sui Ishida"),
                .init(title: "Pokemon", author: "Sonia Sander"),
                .init(title: "Savage Awakening", author: "Adastra339 "),
                .init(title: "The Sun Also Rises", author: "F. Scott Fitzgerald"),
                .init(title: "The Lovely Bones", author: "Alice Sebold"),
                .init(title: "The Great Gatsby", author: "F. Scott Fitzgerald"),
                .init(title: "Blue Lock", author: "Muneyuki Kaneshiro"),
                .init(title: "Dragon Ball", author: "Akira Toriyama"),
                .init(title: "Beyblade Burst T07", author: "Hiro Morita"),
    ]
    
    
    @Published var images: [Book: Image] = [:]
    
    init() {
        if let Fahrenhei451 = booksCache.first(where: { $0.title == "Fahrenheit 451"}) {
            images[Fahrenhei451] = Image("book1")
        }
        if let RoadsidePicnic = booksCache.first(where: { $0.title == "Roadside Picnic"}) {
            images[RoadsidePicnic] = Image("book2")
        }
        if let BladeRunner = booksCache.first(where: { $0.title == "Blade Runner"}) {
            images[BladeRunner] = Image("book3")
        }
        if let G1984 = booksCache.first(where: { $0.title == "1984"}) {
            images[G1984] = Image("book4")
        }
        if let ArtofWar = booksCache.first(where: { $0.title == "Art of War"}) {
            images[ArtofWar] = Image("book5")
        }
    }
}
 
enum Section: CaseIterable{
    case myFavoriteBooks
    case finished
}
