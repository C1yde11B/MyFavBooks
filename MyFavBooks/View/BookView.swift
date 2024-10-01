//
//  BookView.swift
//  MyFavBooks
//
//  Created by AM Student on 9/26/24.
//

import SwiftUI

struct BookView: View {

    let book: Book
    let titleFont: Font
    let authorFont: Font

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
            Text(book.author)
                .font(authorFont)
        }
    }
}

extension Book {

    struct Image: View {

        let image: SwiftUI.Image?
        let title: String
        var size: CGFloat?
        let cornerRadius: CGFloat

        var body: some View {
            if let image = image {
                //Renders the sustom image modifiers.
                image
                    .resizable()
                    .frame(width: size, height: size)
                    .cornerRadius(cornerRadius)
            } else {
                // Generates a system image (book icon) using the first character of the book's title, if there is no book image.
                let symbol =
                    SwiftUI.Image(title: title)

                    // If the system image cannot be generated, fallback is the book icon.
                    ?? .init(systemName: "book")

                symbol
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .font(Font.title.weight(.light))
                    .foregroundColor(.secondary.opacity(0.5))
            }

        }
    }
}

extension Image {
    // Initalizes an Image with a system symbol derived from the fisrt character of the provided title.
    init?(title: String) {
        // Extracts the first character from the title.
        guard let character = title.first,
            // Cerates a sybmol name based on the lowercase representation of the first character followed by a square
            case let symbolName = "\(character.lowercased()).square",
            // Checks if a system image exists for the generated symbol name.
            UIImage(systemName: symbolName) != nil
        else {
            // if no system image is found, return nil.
            return nil
        }
        // Intialize the Image with the system symbol name.
        self.init(systemName: symbolName)
    }
}

// Initaializes the book image.
extension Book.Image {
    init(title: String) {
        self.init(image: nil, title: title, cornerRadius: .init())
    }
}

#Preview {
    VStack {
        BookView(book: .init(), titleFont: .title, authorFont: .title2)
        Book.Image(title: Book().title)
        Book.Image(title: "")
        Book.Image(title: "📖")
    }
}
