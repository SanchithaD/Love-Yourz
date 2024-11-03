//
//  Mood.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import Foundation
import SwiftUI

enum EmotionState: String, Codable {
    case happy
    case sad
    case scared
    case confused
    case loved
    case angry
}



struct Mood: Codable, Equatable, Identifiable {
    var id = UUID()
    let emotion: EmotionState
    var comment: String?
    let date: Date
    
    init(emotion: EmotionState, comment: String?, date: Date) {
        self.emotion = emotion
        self.comment = comment
        self.date = date
    }
    
    var dateString: String {
        dateFormatter.string(from: date)
    }
    
    var monthString: String {

    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "LLL"
    
    let month = dateFormatter1.string(from: date)
    
    return month
    
    }
    
    var dayAsInt: Int {
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    
    var year: String {
        return Calendar.current.component(.year, from: date).description
    }
    
    
    static func == (lhs: Mood, rhs: Mood) -> Bool {
        if lhs.date == rhs.date {
            return true
        } else {
            return false
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
