import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: Image?
// Creates and returns a Coordinator instance to manage PHPickerViewControllerDelegate methods.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    //Configures and return the PHPickerViewController with image filter applied
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        // The filter is applying image processing operation
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    // Update the PhPickerViewController. This Empty because there's no need to update the view contoller.
    func updateUIViewController(
        _ uiViewController: PHPickerViewController, context: Context
    ) {}
    // Coordinator class to handle PHPickerViewController Delegate methods

    class Coordinator: NSObject, PHPickerViewControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(
            _ picker: PHPickerViewController,
            didFinishPicking results: [PHPickerResult]
        ) {

            //dismisses the picker view
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            //Checks if the itemProvider can load a UIIMage
            if provider.canLoadObject(ofClass: UIImage.self) {

                //loads the UIImage
                provider.loadObject(ofClass: UIImage.self) { image, _ in

                    //ensures the image loading is done
                    DispatchQueue.main.async {

                        if let uiImage = image as? UIImage {
                            self.parent.image = Image(uiImage: uiImage)
                        }
                    }
                }
            }
        }
    }
}
