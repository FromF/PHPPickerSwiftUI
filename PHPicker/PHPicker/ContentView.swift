//
//  ContentView.swift
//  PHPicker
//
//  Created by 藤 治仁 on 2020/07/12.
//

import SwiftUI

struct ContentView: View {
    @State var images: [UIImage] = []
    @State var picker = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15.0) {
                        ForEach(images,id: \.self){image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 250.0, height: 250.0)
                                .cornerRadius(25)
                            
                        }
                    }
                })
            }
            
            Spacer()
            
            Button(action: {
                picker.toggle()
            }) {
                Text("画像を選択する")
                    .foregroundColor(.white)
                    .padding(.vertical, 10.0)
                    .padding(.horizontal, 35.0)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 16.0)
        }
        .sheet(isPresented: $picker) {
            // Pickerを開く
            ImagePicker(images: $images, picker: $picker)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
