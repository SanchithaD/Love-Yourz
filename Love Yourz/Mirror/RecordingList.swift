//
//  RecordingList.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 8/1/24.
//
import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                        if(recording.fileURL.lastPathComponent != "mood.plist") {
                            VStack {
                                RecordingRow(audioURL: recording.fileURL, audioRecorder: audioRecorder)
                            }.padding(.horizontal,10)
                            .frame(width: 370, height: 85)
                            .listRowBackground(
                                        Capsule()
                                            .fill(Color(red: 153 / 255, green: 102 / 255, blue: 204 / 255))
                                            .padding(10)
                                    )
                        }
                        
                                                    
                    }
                    .onDelete(perform: delete)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack{
            Image(systemName:"headphones.circle.fill")
                .font(.system(size:50))
            
            VStack(alignment:.leading) {
                Text("\(audioURL.lastPathComponent)")
            }
            VStack {

                if audioPlayer.isPlaying == true {
                    
                    Button(action: {
                        audioPlayer.stopPlayback()
                    }) {
                        Image(systemName: "stop.circle")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                }else{
                    Button(action: {
                        audioPlayer.startPlayback(audio: self.audioURL)
                    }) {
                        Image(systemName: "play.circle")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                        
                    }
                }
                    
               
            
        }.padding()
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}

//#Preview {
//    RecordingList()
//}
