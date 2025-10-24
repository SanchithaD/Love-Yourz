//
//  MultiLineTextField.swift
//  MoodDiary
//
//  Created by Sanchitha Dinesh on 7/29/24.
//

import Foundation
import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var txt: String?
    @Binding var counterLabel: String
    
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        
        return MultiLineTextField.Coordinator(parent1: self)
    }
    func makeUIView(context: Context) -> UITextView {
        
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        if self.txt != nil {
            
            text.text = self.txt
            text.textColor = .black
        } else {
            
            text.text = ""
            text.textColor = .black
        }
        
        text.layer.borderColor = UIColor(red: 99/255, green: 115/255, blue: 106/255, alpha: 1).cgColor
        text.layer.borderWidth = 1.0
        text.layer.cornerRadius = 5
        text.backgroundColor = UIColor(.clear)
        text.font = .systemFont(ofSize: 16)
        text.returnKeyType = .done
        text.delegate = context.coordinator
        text.inputAccessoryView = UIView()//Removes the "done" button from the top of the keyboard.
        text.leftSpace()
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        
        var parent: MultiLineTextField
        
        init(parent1: MultiLineTextField) {
            
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {


            if self.parent.txt == "" {
                            
            textView.text = ""
            textView.textColor = .black
            }
        }

        //Called when ever we start typing in the text view.
        func textViewDidChange(_ textView: UITextView) {

            self.parent.txt = textView.text
            
            //Calculation of characters
               let allowed = 2000
               let typed = textView.text.count
               let remaining = allowed - typed
               
            self.parent.counterLabel = "\(remaining)/2000"
        }
        
        /* Updated for Swift 4 */
        //Runs FIRST when ever text view is about to be changed. Returns true, means allow change, false means do not allow.
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            
            //Do not allow white lines (breaks)
             guard text.rangeOfCharacter(from: .newlines) == nil else {
                 return false
             }
             //Stop entry while reached 101 chars
            return textView.text.count + (text.count - range.length) <= 2000
            
            
          //  return true
        }
    }
}

extension UITextView {
    func leftSpace() {
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
