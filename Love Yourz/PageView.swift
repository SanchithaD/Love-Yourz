//
//  PageView.swift
//  AdventureStory
//
//  Created by Shashwath Dinesh on 4/7/24.
//

import SwiftUI

struct PageView: View {
    @Binding var choiceMade: Int
    
    var body: some View {
        
        let currentPage: Story = stories[choiceMade]
        
        NavigationStack{
            ZStack {
                Image("new_world_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(currentPage.storyImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding()
                    Text(currentPage.storyText)
                        .foregroundColor(.white)
                        .padding()
                        .background(.purple)
                    
                    if currentPage.endOfStory {
                        //display the end
                        NavigationLink(destination: ContentView()) {
                            Text("Start Over")
                        }
                        .buttonStyle(ChoiceButtonStyle(backgroundColor: .blue))
                        
                    } else {
                        NavigationLink(destination: PageView(choiceMade: .constant(currentPage.choice1Destination))) {
                            Text(currentPage.choice1)
                        }
                        .buttonStyle(ChoiceButtonStyle(backgroundColor: .blue))
                        .padding()
                        
                        NavigationLink(destination: PageView(choiceMade: .constant(currentPage.choice2Destination))) {
                            Text(currentPage.choice2)
                        }
                        .buttonStyle(ChoiceButtonStyle(backgroundColor: .red))
                        .padding()
                    }
                }
            }
        }
    }
}

struct ChoiceButtonStyle: ButtonStyle {
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.headline)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(choiceMade: .constant(1))
    }
}
