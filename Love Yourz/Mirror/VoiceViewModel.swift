//
//  VoiceViewModel.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 8/1/24.
//
//
//import Foundation
//import AVFoundation
//
//class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate, AVAudioRecorderDelegate{
//    
//    var audioRecorder : AVAudioRecorder!
//    var audioPlayer : AVAudioPlayer!
//    
//    var indexOfPlayer = 0
//    
//    @Published var isRecording : Bool = false
//    
//    @Published var recordingsList = [Recording]()
//    
//    @Published var countSec = 0
//    @Published var timerCount : Timer?
//    @Published var blinkingCount : Timer?
//    @Published var timer : String = "0:00"
//    @Published var toggleColor : Bool = false
//    
//    
//    var playingURL : URL?
//    
//    override init(){
//        super.init()
//        
//        fetchAllRecording()
//        
//    }
//    
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//       
//        for i in 0..<recordingsList.count {
//            if recordingsList[i].fileURL == playingURL {
//                recordingsList[i].isPlaying = false
//            }
//        }
//    }
//    
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//               finishRecording(success: false)
//           }
//    }
//    
//    
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//    }
//  
//    
////    func startRecording() {
////        
////        let recordingSession = AVAudioSession.sharedInstance()
////        do {
////            try recordingSession.setCategory(.playAndRecord, mode: .default)
////            try recordingSession.setActive(true)
////        } catch {
////            print("Cannot setup the Recording")
////            finishRecording(success: false)
////        }
////        
////        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
////        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
////        
////        
////                let settings: [String: Any] = [
////                    AVFormatIDKey: kAudioFormatMPEG4AAC,
////                    AVSampleRateKey: 22050,
////                    AVEncoderBitRateKey: 128000,
////                    AVNumberOfChannelsKey: 2,
////                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
////                ]
////        
//////        let settings = [
//////            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//////            AVSampleRateKey: 12000,
//////            AVNumberOfChannelsKey: 1,
//////            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//////        ]
//////        
////        
////        do {
////            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
////            audioRecorder.delegate = self
////            //audioRecorder.prepareToRecord()
////            audioRecorder.record()
////            isRecording = true
////            
//////            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
//////                self.countSec += 1
//////                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
//////            })
//////            blinkColor()
////            
////        } catch {
////            finishRecording(success: false)
////            print("Failed to Setup the Recording")
////        }
////    }
//    
//    func startRecording() {
//        let recordingSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
//            try recordingSession.setActive(true)
//        } catch {
//            print("Failed to set up recording session")
//        }
//        
//        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
//        
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//        
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.record()
//
//            isRecording = true
//        } catch {
//            print("Could not start recording")
//        }
//    }
//    
//    func stopRecording() {
//        audioRecorder.stop()
//        isRecording = false
//        
//        //fetchRecording()
//    }
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//    
//    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
//        print("AUDIO RECORDER ERROR \(error?.localizedDescription)")
//    }
//    
////    func startRecording() {
////        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
////
////        do {
////            let recordingSession = AVAudioSession.sharedInstance()
////            try recordingSession.setCategory(.playAndRecord, mode: .default)
////            try recordingSession.setActive(true)
////        } catch {
////            
////        }
////        
////        let settings: [String: Any] = [
////            AVFormatIDKey: kAudioFormatMPEG4AAC,
////            AVSampleRateKey: 22050,
////            AVEncoderBitRateKey: 128000,
////            AVNumberOfChannelsKey: 2,
////            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
////        ]
////
////        do {
////            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
////            audioRecorder.delegate = self
////            audioRecorder.record()
////
////            //recordButton.setTitle("Tap to Stop", for: .normal)
////        } catch {
////            finishRecording(success: false)
////        }
////    }
////    
////    func stopRecording(){
////        
////        audioRecorder.stop()
////        
////        isRecording = false
////        
////        self.countSec = 0
////        
////        timerCount!.invalidate()
////        blinkingCount!.invalidate()
////        
////    }
////    
//    
//    func fetchAllRecording(){
//        
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
//
//        for i in directoryContents {
//            recordingsList.append(Recording(fileURL : i, createdAt:getFileDate(for: i), isPlaying: false))
//        }
//        
//        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
//        
//    }
//    
//    
//    func startPlaying(url : URL) {
//        
//        playingURL = url
//        
//        let playSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
//        } catch {
//            print("Playing failed in Device")
//        }
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.delegate = self
//            audioPlayer.prepareToPlay()
//            audioPlayer.play()
//            
//            for i in 0..<recordingsList.count {
//                if recordingsList[i].fileURL == url {
//                    recordingsList[i].isPlaying = true
//                }
//            }
//            
//        } catch {
//            print("Playing Failed")
//        }
//        
//        
//    }
//    
//    func stopPlaying(url : URL) {
//        
//        audioPlayer.stop()
//        
//        for i in 0..<recordingsList.count {
//            if recordingsList[i].fileURL == url {
//                recordingsList[i].isPlaying = false
//            }
//        }
//    }
//    
// 
//    func deleteRecording(url : URL) {
//        
//        do {
//            try FileManager.default.removeItem(at: url)
//        } catch {
//            print("Can't delete")
//        }
//        
//        for i in 0..<recordingsList.count {
//            
//            if recordingsList[i].fileURL == url {
//                if recordingsList[i].isPlaying == true{
//                    stopPlaying(url: recordingsList[i].fileURL)
//                }
//                recordingsList.remove(at: i)
//                
//                break
//            }
//        }
//    }
//    
//    func blinkColor() {
//        
//        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (value) in
//            self.toggleColor.toggle()
//        })
//        
//    }
//    
//    
//    func getFileDate(for file: URL) -> Date {
//        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
//            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
//            return creationDate
//        } else {
//            return Date()
//        }
//    }
//    
//    
//    
//}
//
//
//
//
//extension VoiceViewModel {
//    func covertSecToMinAndHour(seconds : Int) -> String{
//        
//        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
//        let sec : String = s < 10 ? "0\(s)" : "\(s)"
//        return "\(m):\(sec)"
//        
//    }
//}
