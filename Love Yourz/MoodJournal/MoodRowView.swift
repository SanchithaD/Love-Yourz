//
//  MoodRowView.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import SwiftUI

struct MoodRowView: View {
    var mood: Mood
    
    var body: some View {
        ZStack {
            HStack {
                Text(mood.monthString + " \(mood.dayAsInt)")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 99/255, green: 115/255, blue: 106/255))
                Spacer().frame(width: 30)
                Text(mood.comment?.prefix(50) ?? "Blank").font(.footnote).fontWeight(.regular)
                    .foregroundColor(.black)
                
                
            }
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
        return Image(imageName).resizable().frame(width: 60, height: 50)
    }
}

struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRowView(mood: Mood(emotion: .happy, comment: "Test", date: Date()))
    }
}
