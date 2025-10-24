//
//  Colors.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import Foundation
import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)
class Colors: ObservableObject {

    //Foreground
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.blue
    @Published var disabledColor: Color = Color.gray
    @Published var selectedColor: Color = Color.primary

    //Background
    @Published var backgroundColor: Color = Color.clear
    @Published var weekdayBackgroundColor: Color = Color.clear
    @Published var selectedBackgroundColor: Color = Color.orange

}
