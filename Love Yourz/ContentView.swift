//
//  ContentView.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.lightPurple, Color.lightPink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack {
                    Text("Love Yourz")
                        .font(.custom("AcademyEngravedLetPlain", size: 56))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    
                    
                    Text("Track your emotions and reflect on your life")
                        .font(.system(size: 16, design: .monospaced))
                        .foregroundColor(.white)
                        .bold()
                        
                    NavigationLink(destination: Journal()) {
                        Image("journal")
                            .resizable()
                            .frame(width: 200, height: 200)
                    
                    }
                    Text("Gaze in the mirror and boost your confidence with affirmations")
                        .font(.system(size: 16, design: .monospaced))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    NavigationLink(destination: AffirmationsMirror(audioRecorder: AudioRecorder())) {
                        Image("affirmationsmirror")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    
                    }
                }
                
            }.ignoresSafeArea()
            
        }
        .navigationTitle("Love Yourz")
        .navigationBarHidden(false)
        
    }
}

extension Color {
    static let lightPink = Color(red: 253 / 255, green: 181 / 255, blue: 239 / 255)
    static let lightPurple = Color(red: 174 / 255, green: 130 / 255, blue:  203 / 255)
}

#Preview {
    ContentView()
}
