//
//  ImagePicker.swift
//  PHPicker
//
//  Created by 藤 治仁 on 2020/07/12.
//

import SwiftUI
import PhotosUI

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        // 静止画を選択
        configuration.filter = .images
        // 複数選択可能（上限枚数なし）
        configuration.selectionLimit = 0
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // Pickerを閉じる
            parent.picker.toggle()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        
                        if let image = image as? UIImage {
                            // 選択された画像を追加する
                            self.parent.images.append(image)
                        } else {
                            print("Error(1)")
                        }
                        
                    }
                } else {
                    print("Error(2)")
                }
            }
        }
    }
}

//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker(images: Binding<[UIImage]>, picker: <#Binding<Bool>#>)
//    }
//}
