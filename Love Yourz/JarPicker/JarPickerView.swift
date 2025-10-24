//
//  ContentView.swift
//  iReceipt
//
//  Created by Federico on 26/01/2022.
//

import SwiftUI

struct JarPickerView: View {
    @StateObject var imageData = ImageData()
    @State var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if imageData.imageNote.isEmpty {
                    VStack{
                        Spacer()
                        Spacer()
                        Text("Try adding an image!")
                            .italic()
                            .foregroundColor(.gray)
                            Spacer()
                        Spacer()
                        VStack {
                            Text("Red: Something you are grateful for")
                                .foregroundColor(.red)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            Text("Green: Something you are looking forward to")
                                .foregroundColor(.green)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            Text("Blue: Someone you are thankful for")
                                .foregroundColor(.blue)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            Text("Purple: Something you love about yourself")
                                .foregroundColor(.purple)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }.frame(maxWidth: .infinity, maxHeight: 200)
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    }
                } else {
                    HomeView()
                }
            }
            .navigationTitle("Notes Jar")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    imageData.addNote(image: image,
                                      title: "Untitled",
                                      desc: "", color: [0, (128/255), 0])
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Label("Image", systemImage: "photo.on.rectangle.angled")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            imageData.resetUserData()
                        }
                    } label: {
                        Label("Image", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        .environmentObject(imageData)
    }
}


