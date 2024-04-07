//
//  HomeView.swift
//  iReceipt
//
//  Created by Federico on 26/01/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var imageData : ImageData
    
    
    var body: some View {
        VStack{
            List {
                ForEach(imageData.imageNote) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        HStack {
                            Image(uiImage: UIImage(data: note.image)!)
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                            Image(systemName: Constants.Icons.line3HorizontalCircleFill)
                                .foregroundColor(Color(red: note.selectedColor[0], green: note.selectedColor[1], blue: note.selectedColor[2]))
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ImageData())
    }
}
