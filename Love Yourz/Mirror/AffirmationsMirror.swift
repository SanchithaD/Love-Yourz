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
    @ObservedObject var audioRecorder = AudioRecorder()
    
    @State private var showingList = false
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false
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
                Text("Record your affirmations below using the guided audios or your own!")
                    .font(.custom("AcademyEngravedLetPlain", size: 18)).bold()
                if let image = image {
                    Image(image, scale: 2.0, orientation: .up, label: label)
                        .frame(width: 400, height: 400)
                        .clipShape(.rect)
                } else {
                    Color.black
                }
                
                HStack {
                    Button(action: {
                        if audioRecorder.recording == true {
                            audioRecorder.stopRecording()
                        }
                        showingList.toggle()
                    }) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                            .font(.system(size: 45, weight: .bold))
                    }.sheet(isPresented: $showingList, content: {
                        RecordingsList(audioRecorder: audioRecorder)
                    })
                    Spacer().frame(width: 80)
                    if audioRecorder.recording == false {
                        Button(action: {self.audioRecorder.startRecording()}) {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 45))
                        }
                    } else {
                        Button(action: {self.audioRecorder.stopRecording()}) {
                            Image(systemName: "stop.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 45))
                        }
                        
                    }
                }
                Spacer().frame(height: 50)
                VStack {
                    Text(messageString)
                        .font(.custom("AcademyEngravedLetPlain", size: 18))
                    Button("Generate Affirmation") {
                        let messages = ["Changing my mind is a strength, not a weakness.", "I affirm and encourage others, as I do myself.", "I am growing and I am going at my own pace.", "I am loved and worthy.", "I am optimistic because today is a new day.", "I am peaceful and whole."]
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
//                        if (messageString == "Every decision I make is supported by my whole and inarguable experience.") {
//                            soundName = "EveryDecision"
//                        }
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
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 150, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 211/255, green: 191/255, blue: 217/255), Color(red: 200/255, green: 148/255, blue: 214/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(10)
                    .shadow(color: Color.white, radius: 10)
                    .foregroundColor(.white)
                    .bold()

                }
            }
        }
    }
}
struct AffirmationsMirror: View {
    @StateObject private var model = FrameHandler()
    @State private var imageData: Data? = nil
    @State private var showCamera: Bool = false
    var audioRecorder: AudioRecorder
    
    
    var body: some View {
        FrameView(image: model.frame, audioRecorder: audioRecorder)
            .ignoresSafeArea()
    }
}



//#Preview {
//    AffirmationsMirror(audioRecorder: AudioRecorder)
//}
