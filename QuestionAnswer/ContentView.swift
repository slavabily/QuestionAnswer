//
//  ContentView.swift
//  QuestionAnswer
//
//  Created by slava bily on 21/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var question = ""
    @State private var answer1 = ""
    @State private var answer2 = ""
    
    let words = ["I", "You", "He", "She","We", "They"]
    let translations = ["Yo", "Tu", "El", "Ella", "Nosotros", "Ellos"]
    
    let dict = [
        "I": "Yo",
        "You": "Tu",
        "He": "El",
        "She": "Ella",
        "We": "Nosotros",
        "They": "Ellos"
    ]
    
    var body: some View {
        VStack {
            Text("Please, select correct translation:\n \(question)")
                .font(.title)
                .padding()
            
            HStack {
                Button("\(answer1) ") {
                    isCorrect(question: question, answer: answer1)
                }
                .font(.headline)
                .padding()
                
                Spacer()
                
                Button("\(answer2)") {
                     isCorrect(question: question, answer: answer2)
                }
                .font(.headline)
                .padding()
            }
            
            Button("Continue") {
                nextWord()
                translation(question: question)
            }
            .font(.title)
            
        }
        .onAppear {
            nextWord()
            translation(question: question)
        }
    }
    
    func nextWord() {
        question = words.randomElement()!
    }
    
    func translation(question: String) {
        var answers: [String]
        let wrongAnswer: String
        
        if let correctAnswer = dict[question] {
            if let i = translations.firstIndex(of: correctAnswer) {
                switch i {
                case 0..<translations.endIndex - 1:
                    wrongAnswer = translations[i + 1]
                    answers = [correctAnswer, wrongAnswer].shuffled()
                    answer1 = answers[0]
                    answer2 = answers[1]
                case translations.endIndex - 1:
                    wrongAnswer = translations[i - 1]
                    answers = [correctAnswer, wrongAnswer].shuffled()
                    answer1 = answers[0]
                    answer2 = answers[1]
                default:
                    break
                }
            }
        }
    }
    
    func isCorrect(question: String, answer: String) -> Bool {
        
        if dict[question] == answer {
            print("Correct!")
            return true
        } else {
            print("Incorrect!\n The correct answer is: \(dict[question]!)")
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

