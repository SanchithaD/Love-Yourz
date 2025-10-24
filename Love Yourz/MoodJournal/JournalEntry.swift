//
//  JournalEntry.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 7/30/24.
//

import SwiftUI

struct JournalEntry: View {
    var mood: Mood
    @State private var counterLabel = "2000/2000"
//    @Binding var text: String

    var body: some View {
            VStack(spacing: 5) {
                Text(mood.monthString + " " + String(mood.dayAsInt))
                    .font(.title).bold().foregroundColor(Color(red: 99/255, green: 115/255, blue: 106/255))
                ZStack(alignment: .center) {
                    Image("notebook").resizable().frame(width: 400, height: 550)
                        VStack {
                            HStack {
                                //                            ScrollView {
                                Spacer().frame(width: 30)
                                Text(mood.comment ?? "").frame(width: 270, height: 470)
                                
                                    .padding()
                            }
                        
                    }
                    
                }
                moodImage()
            }
    }
    func moodImage() -> some View {
        var imageName = "none"
        
        switch mood.emotion {
        case .happy:
            imageName = "happy"
        case .angry:
            imageName = "angry"
        case .sad:
            imageName = "sad"
        case .confused:
            imageName = "confused"
        case .loved:
            imageName = "loved"
        case .scared:
            imageName = "scared"
        }
        return Image(imageName).resizable().frame(width: 80, height: 70)
    }
}

#Preview {
    JournalEntry(mood:  Mood(emotion: .happy, comment: "Test", date: Date()))
}
