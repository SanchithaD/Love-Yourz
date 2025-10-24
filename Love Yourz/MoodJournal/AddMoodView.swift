//
//  AddMoodView.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import SwiftUI

struct AddMoodView: View {
    @ObservedObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var text: String? = nil
    @State private var emotionState: EmotionState = .happy
    @State private var happyIsSelected = false
    @State private var sadIsSelected = false
    @State private var angryIsSelected = false
    @State private var scaredIsSelected = false
    @State private var lovedIsSelected = false
    @State private var confusedIsSelected = false
    @State private var isRecording = false
    
    @State private var counterLabel = "2000/2000"
    var customGreen = Color(red: 186/255, green: 217/255, blue: 200/255)
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Spacer()
                Text("How was your day?").bold().foregroundColor(Color(red: 99/255, green: 115/255, blue: 106/255))
                ZStack(alignment: .center) {
                    Image("notebook").resizable().frame(width: 400, height: 550)
                    ZStack(alignment: .bottomTrailing) {
                        HStack {
                            Spacer().frame(width: 30)
                            MultiLineTextField(txt: $text, counterLabel: $counterLabel).frame(width: 270, height: 470)
                        }
                        Text("Remaining: \(counterLabel)").font(.footnote).foregroundColor(Color(red: 99/255, green: 115/255, blue: 106/255)).padding([.bottom, .trailing], 8)
                        
                    }
                }
                
                HStack {
                    Text("Feeling").bold().font(.system(size: 25))
                    Spacer().frame(width:250)
                }
                HStack {
                    Button(action: {
                        self.emotionState = .happy
                        self.happyIsSelected = true
                        self.angryIsSelected = false
                        self.sadIsSelected = false
                        self.scaredIsSelected = false
                        self.lovedIsSelected = false
                        self.confusedIsSelected = false
                        speechRecognizer.requestPermissions()

                    }) {
                        Image("happy").resizable().frame(width: 50, height:43).background(happyIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    
                    
                    Button(action: {
                        self.emotionState = .sad
                        self.sadIsSelected = true
                        self.happyIsSelected = false
                        self.angryIsSelected = false
                        self.scaredIsSelected = false
                        self.lovedIsSelected = false
                        self.confusedIsSelected = false
                    }) {
                        Image("sad").resizable().frame(width: 50, height: 43).background(sadIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    Button(action: {
                        self.emotionState = .angry
                        self.sadIsSelected = false
                        self.happyIsSelected = false
                        self.angryIsSelected = true
                        self.scaredIsSelected = false
                        self.lovedIsSelected = false
                        self.confusedIsSelected = false
                    }) {
                        Image("angry").resizable().frame(width: 50, height: 40).background(angryIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    Button(action: {
                        self.emotionState = .scared
                        self.sadIsSelected = false
                        self.happyIsSelected = false
                        self.angryIsSelected = false
                        self.scaredIsSelected = true
                        self.lovedIsSelected = false
                        self.confusedIsSelected = false
                    }) {
                        Image("scared").resizable().frame(width: 50, height: 40).background(scaredIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    Button(action: {
                        self.emotionState = .loved
                        self.sadIsSelected = false
                        self.happyIsSelected = false
                        self.angryIsSelected = false
                        self.scaredIsSelected = false
                        self.lovedIsSelected = true
                        self.confusedIsSelected = false
                    }) {
                        Image("loved").resizable().frame(width: 50, height: 50).background(lovedIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    Button(action: {
                        self.emotionState = .confused
                        self.sadIsSelected = false
                        self.happyIsSelected = false
                        self.angryIsSelected = false
                        self.scaredIsSelected = false
                        self.lovedIsSelected = false
                        self.confusedIsSelected = true
                    }) {
                        Image("confused").resizable().frame(width: 50, height: 50).background(confusedIsSelected ? customGreen : Color.clear).clipShape(Circle())
                    }
                    
                }
                Spacer().frame(height: 10)
                HStack {
                    Button(action: {
                        self.moodModelController.createMood(emotion: self.emotionState, comment: self.text, date: Date())
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Text("Add Journal Entry").bold().frame(width: UIScreen.main.bounds.width - 30, height: 50).background(customGreen).foregroundColor(Color.black).cornerRadius(10)
                        
                        
                        
                    }
                    Button(action: {
                        if !isRecording {
                            speechRecognizer.transcribe()
                        } else {
                            speechRecognizer.stopTranscribing()
                        }
                        
                        isRecording.toggle()
                    }) {
                        if isRecording == false {
                            Image(systemName: "mic.fill")
                                .font(.system(size: 45))
                            
                        } else {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 45))
                            
                        }
                    }
                }
            }.padding()
                .onChange(of: speechRecognizer.transcript) {
                    text = speechRecognizer.transcript
                }
        }
    }
    
}

struct AddMoodView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AddMoodView(moodModelController: MoodModelController(), text: "text")
    }
}
