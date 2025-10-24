//
//  WeekdaysView.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct WeekdaysView: View {
    let weekdays = ["Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"]
    let colors = Colors()

    var body: some View {
        HStack {
            GridStack(rows: 1, columns: 7) { row, col in
                Text(self.weekdays[col])
            }
        }.padding(.bottom, 20).background(colors.weekdayBackgroundColor)
    }
}

@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct WeekdaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdaysView()
    }
}
