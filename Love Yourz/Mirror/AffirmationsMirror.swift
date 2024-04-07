//
//  AffirmationsMirror.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 4/6/24.
//

import SwiftUI
import AVFAudio

struct FrameView: View {
    
    var image: CGImage?
    private let label = Text("frame")
    @State private var messageString = ""
    @State private var messageNumber = 0
    @State private var audioPlayer: AVAudioPlayer!
    @State private var soundName = ""
    var body: some View {
        ZStack {
            Color(red: 153 / 255, green: 102 / 255, blue: 204 / 255)
                .ignoresSafeArea()
            VStack {
                Text("Affirmations")
                    .font(.custom("AcademyEngravedLetPlain", size: 36))
                if let image = image {
                    Image(image, scale: 1.0, orientation: .up, label: label)
                        .frame(width: 350, height: 550)
                        .clipShape(.ellipse)
                } else {
                    Color.black
                }
                
                Text(messageString)
                    .font(.custom("AcademyEngravedLetPlain", size: 18))
                Button("Next Affirmation") {
                    let messages = ["Changing my mind is a strength, not a weakness.", "I affirm and encourage others, as I do myself.", "Every decision I make is supported by my whole and inarguable experience.", "I am growing and I am going at my own pace.", "I am loved and worthy.", "I am optimistic because today is a new day.", "I am peaceful and whole."]
                    messageString = messages[messageNumber]
                    messageNumber += 1
                    if (messageNumber == messages.count - 1) {
                        messageNumber = 0
                    }
                    
                    if (messageString == "Changing my mind is a strength, not a weakness.") {
                        soundName = "ChangingMyMind"
                    }
                    if (messageString == "I affirm and encourage others, as I do myself.") {
                        soundName = "IAffirm"
                    }
                    if (messageString == "Every decision I make is supported by my whole and inarguable experience.") {
                        soundName = "EveryDecision"
                    }
                    if (messageString == "I am growing and I am going at my own pace.") {
                        soundName = "IAmGrowing"
                    }
                    if (messageString == "I am loved and worthy.") {
                        soundName = "IAmLovedAndWorthy"
                    }
                    if (messageString == "I am optimistic because today is a new day.") {
                        soundName = "IAmOptimistic"
                    }
                    if (messageString == "I am peaceful and whole.") {
                        soundName = "IAmPeaceful"
                    }
                    guard let soundFile = NSDataAsset(name: soundName) else {
                        return
                    }
                    do {
                       audioPlayer = try AVAudioPlayer(data: soundFile.data)
                        audioPlayer.play()

                    } catch {
                        
                    }
                                    }
                .foregroundColor(.white)
            }
        }
    }
}
struct AffirmationsMirror: View {
    @StateObject private var model = FrameHandler()
    @State private var imageData: Data? = nil
    @State private var showCamera: Bool = false
    
    var body: some View {
        FrameView(image: model.frame)
            .ignoresSafeArea()
    }
}



#Preview {
    AffirmationsMirror()
}
