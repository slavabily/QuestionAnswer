//
//  ContentView.swift
//  QuestionAnswer
//
//  Created by slava bily on 21/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var question = ""
    @State private var answer = ""
    
    let words = ["I", "You", "He", "We"]
    
    let translations = ["Yo", "Tu", "el", "Nosotras"]
    
    let dict = [
        "I": "Yo",
        "You": "Tu",
        "He": "el",
        "We": "Nosotras"
    ]
    
    var body: some View {
        VStack {
            Text("Please, select correct translation:\n \(question)")
                .font(.title)
                .padding()
            
            HStack {
                Button(" ") {
                     
                   
                }
                .font(.headline)
                .padding()
                
                Spacer()
                
                Button(" ") {
                     
                    
                }
                .font(.headline)
                .padding()
            }
            .offset(y: 100)
            
            Button("Continue") {
                nextWord()
            }
            .font(.title)
            
        }
        .onAppear {
            nextWord()
        }
    }
    
    func nextWord() {
        question = words.randomElement()!
    }
    
    func translation() -> String {
        translations.randomElement()!
    }
    
    func isCorrect(question: String, answer: String) -> Bool {
        
        if dict[question] == answer {
            return true
        } else {
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

