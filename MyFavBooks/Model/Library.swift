//
//  Library.swift
//  MyFavBooks
//
//  Created by AM Student on 9/30/24.
//

import Combine
import SwiftUI

class Library: ObservableObject {

    var sortedBooks: [Section: [Book]] {
        //orgonizes books into sections based on their properties
        get {
            let groupedBooks = Dictionary(
                grouping: booksCache, by: \.myFavoriteBook)
            //map grouped book to sections and return as a dictionary
            return Dictionary(
                uniqueKeysWithValues: groupedBooks.map {
                    //uses a ternary operator (one code is true, one is false) to maps keys to correspinding section types.
                    (($0.key ? .myFavoriteBooks : .finished), $0.value)
                })
        }
        set {
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
    func addNewBook(_ book: Book, image: Image?) {
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
        .init(title: "Gravity And Divinity System", author: "Hunter Mythos"),
        .init(title: "tokyo ghoul", author: "Sui Ishida"),
        .init(title: "Pokemon", author: "Sonia Sander"),
        .init(title: "Savage Awakening", author: "Adastra339 "),
        .init(title: "The Lovely Bones", author: "Alice Sebold"),
        .init(title: "The Great Gatsby", author: "F. Scott Fitzgerald"),
        .init(title: "Blue Lock", author: "Muneyuki Kaneshiro"),
        .init(title: "Dragon Ball", author: "Akira Toriyama"),
        .init(title: "Beyblade Burst T07", author: "Hiro Morita"),
    ]

    @Published var images: [Book: Image] = [:]

    init() {
        if let GravityAndDivinitySystem = booksCache.first(where: {
            $0.title == "Gravity And Divinity System"
        }) {
            images[GravityAndDivinitySystem] = Image("book1")
        }
        if let TokyoGhoul = booksCache.first(where: {
            $0.title == "tokyo ghoul"
        }) {
            images[TokyoGhoul] = Image("book2")
        }
        if let Pokemon = booksCache.first(where: { $0.title == "Pokemon" }) {
            images[Pokemon] = Image("book3")
        }
        if let SavageAwakening = booksCache.first(where: {
            $0.title == "Savage Awakening"
        }) {
            images[SavageAwakening] = Image("book4")
        }
        if let DragonBall = booksCache.first(where: {
            $0.title == "Dragon Ball"
        }) {
            images[DragonBall] = Image("book5")
        }
    }
}

enum Section: CaseIterable {
    case myFavoriteBooks
    case finished
}
