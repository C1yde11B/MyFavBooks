//
//  ImagePicker.swift
//  MyFavBooks
//
//  Created by AM Student on 10/1/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker {
    
    @Binding var image: Image?
    
}

class Coordinator {
    
    var parent: ImagePicker
    
    init (_ parent: ImagePicker) {
        self.parent = parent
        
    }
    // PHPickerViewContrllerDelegate method that is called when the user finishs picking an image
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // Dismisses the picker view.
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider else { return }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                
                DispatchQueue.main.async {
                    
                }
                
            }
            
        }
        
    }
}
