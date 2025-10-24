//
//  ContentView.swift
//  AdventureStory
//
//  Created by Shashwath Dinesh on 4/7/24.
//

import SwiftUI

struct AdventureView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("new_world_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("The Lost World")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    NavigationLink(destination: PageView(choiceMade: .constant(0))) {
                        Text("Enter")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }.accentColor(.black)
    }
}


