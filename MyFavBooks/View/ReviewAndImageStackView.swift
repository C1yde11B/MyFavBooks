//
//  ReviewAndImageStackView.swift
//  MyFavBooks
//
//  Created by AM Student on 10/1/24.
//

import SwiftUI

struct ReviewAndImageStackView: View {
    
    @ObservedObject var book: Book
    @Binding var image : Image?
    @State var showImagePicker = false
    @State var showingDialog = false
    
    var body: some View {
        VStack {
            Divider()
                .padding(.vertical)
            TextField("Review", text: $book.microReview)
            Divider()
                .padding(.vertical)
            Book.Image(image: image, title: book.title, cornerRadius: 16)
            
            HStack {
                if image != nil {
                    Spacer()
                    Button("Update Image") {
                        showingDialog = true
                    }
                }
                Spacer()
                Button("Add Image") {
                    showImagePicker = true
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
        
        .confirmationDialog(
            "Delete image for \(book.title)?",
            isPresented: $showingDialog
        ) {
            Button("Delete", role: .destructive) { image = nil }
        } message: {
            Text("Delete image for \(book.title)?")
        }
    }
}
    #Preview {
        ReviewAndImageStackView(book: .init(), image: .constant(nil))
            .padding()
    }
