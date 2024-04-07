//
//  MoodRowView.swift
//  MoodDiary
//
//  Created by Nelson Gonzalez on 3/27/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct MoodRowView: View {
    var mood: Mood
    
    var body: some View {
  ZStack {
  
      Rectangle().fill(Color(hue: 0.75, saturation: 0.4, brightness: 1.0)).cornerRadius(10)
        HStack {
            VStack {
                Text(mood.monthString)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.769, saturation: 1.0, brightness: 0.411))
                Text("\(mood.dayAsInt)")
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.769, saturation: 1.0, brightness: 0.411))
            
            }
            Text(mood.comment ?? "No comment made.").font(.footnote).fontWeight(.regular).foregroundColor(Color(hue: 0.769, saturation: 1.0, brightness: 0.411)).bold()
            
            Spacer()
            
            moodImage()
           
            }.foregroundColor(mood.emotion.moodColor).padding()
        }
    }
    
    func moodImage() -> some View {
        var imageName = "none"
        
        switch mood.emotion.state {
        case .happy:
            imageName = "happy"
        case .meh:
            imageName = "meh"
        case .sad:
            imageName = "sad"
        }
        return Image(imageName).resizable().frame(width: 20, height: 20)
    }
}

struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRowView(mood: Mood(emotion: Emotion(state: .happy, color: .happyColor), comment: "Test", date: Date()))
    }
}
