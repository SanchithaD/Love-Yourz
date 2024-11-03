//
//  DayCellView.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct DayCellView: View {
@ObservedObject var moodModelController: MoodModelController
    @ObservedObject var day: Day

    var body: some View {
        VStack {
        Text(day.dayName).frame(width: 32, height: 32)
            .foregroundColor(day.textColor)
            .clipped()

            moodText()
        
        }.background(day.backgroundColor).clipShape(RoundedRectangle(cornerRadius: 10)).onTapGesture {
                if self.day.disabled == false && self.day.selectableDays {
                    self.day.isSelected.toggle()
                }
        }
    }
    
    func moodText() -> some View {
        var imageName = "none"
        for m in moodModelController.moods {
            if m.monthString == day.monthString && m.dayAsInt == day.dayAsInt && m.year == day.year {
              switch m.emotion {
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
                return Image(imageName).resizable().frame(width: 20, height: 20).opacity(1)
            }
        }
        
        return Image(imageName).resizable().frame(width: 20, height: 20).opacity(0)
    }
}

@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(moodModelController: MoodModelController(), day: Day(date: Date()))
    }
}
