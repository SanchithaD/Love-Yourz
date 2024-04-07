//
//  HomeView.swift
//  MoodDiary
//
//  Created by Nelson Gonzalez on 4/6/24.
//  Copyright © 2024 Shashwath Dinesh. All rights reserved.
//

import SwiftUI

struct MoodJournal: View {
    
    @ObservedObject var moodModelController = MoodModelController()
    @State var show = false
    @State var txt = ""
    @State var docID = ""
    @State var remove = false

    var body: some View {
        NavigationView {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0){
                List {
                    ForEach(self.moodModelController.moods, id: \.id) { mood in
                        Spacer()
                        MoodRowView(mood: mood)
                     
                    }.onDelete { (index) in
                        
                        self.moodModelController.deleteMood(at: index)
                    }
                }.onAppear {
                    UITableView.appearance().tableFooterView = UIView()
                    UITableView.appearance().allowsSelection = true
                    UITableViewCell.appearance().selectionStyle = .none
                    UITableView.appearance().showsVerticalScrollIndicator = false
                }
                Spacer()
                
            }
            Spacer()
            Button(action: {
                
                self.txt = ""
                self.docID = ""
                self.show.toggle()
                
            }) {
                
                Image(systemName: "plus").resizable().frame(width: 18, height: 18).foregroundColor(.black)
                
            }.padding()
                .background(Color.purple)
                .clipShape(Circle())
                .padding()
            
            
        }
            
        .sheet(isPresented: self.$show) {
        
            AddMoodView(moodModelController: self.moodModelController)
            
        }.animation(.default).navigationBarTitle("Journal")
                .toolbarBackground(
                    Color.purple,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarItems(trailing: NavigationLink(destination: CalendarView(start: Date(), monthsToShow: 1, daysSelectable: true, moodController: moodModelController), label: {
            Image(systemName: "calendar")
        }))
            
            
        }.accentColor(Color.black)
    }
    
}

class Host : UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
}


