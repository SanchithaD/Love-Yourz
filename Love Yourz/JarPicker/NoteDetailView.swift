//
//  NoteDetailView.swift
//  iReceipt
//
//  Created by Federico on 26/01/2022.
//

import SwiftUI

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }

    var hex: String {
        String(
            format: "#%02x%02x%02x%02x",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255),
            Int(components.opacity * 255)
        )
    }
}

struct NoteDetailView: View {
    @EnvironmentObject var imageData : ImageData
    @State var note: ImageNote
    @State var selectedColor: Color = .green
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(data: note.image)!)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                    
                    Spacer()
                }
                TextField("Untitled", text: $note.title)
                    .textSelection(.enabled)
                    .onTapGesture {
                        note.title = ""
                    }
                
                ZStack {
                    TextEditor(text: $note.description)
                        .textSelection(.enabled)
                        .frame(height: 200)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(note.description.count)/400")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                VStack {
                    ColorPickerView(selectedColor: $selectedColor)
                        .font(.system(size: 32))
                }.frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    HStack {
                        Spacer()
                        Button("Confirm changes") {
                            imageData.editNote(id: note.id, title: note.title, description: note.description, color: [selectedColor.components.red, selectedColor.components.green, selectedColor.components.blue])
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
            }
        }
    }
    
    
//    struct NoteDetailView_Previews: PreviewProvider {
//        static var previews: some View {
//            let tempImage = UIImage(systemName: "map")?.pngData()
//            
//            NoteDetailView(note: ImageNote(id: UUID(), image: tempImage!, title: "Test", description: "Test Description"))
//                .environmentObject(ImageData())
//        }
//    }
}
