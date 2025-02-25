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
    @State private var isCorrect: Bool? = nil
    @State private var score = UserDefaults.standard.integer(forKey: "Score")
    
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
        NavigationView {
            VStack {
                Text("Please, select correct translation:\n")
                    .font(.title)
                    .padding()
                Text(question)
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    if isCorrect == nil {
                        Button("\(answer1) ") {
                            isCorrect(question: question, answer: answer1)
                        }
                        .font(.title2)
                        .padding()
                        
                        Spacer()
                        
                        Button("\(answer2)") {
                             isCorrect(question: question, answer: answer2)
                        }
                        .font(.title2)
                        .padding()
                    }
                }
                
                if isCorrect != nil {
                    if isCorrect == true {
                        Text("Correct!:)"
                        )
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .clipShape(Capsule())
                            .padding(40)
                    } else {
                        Text("Incorrect!:(\n Correct answer: \(dict[question]!)")
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .clipShape(Capsule())
                            .padding(40)
                    }
                } else {
                    Spacer().frame(minHeight: 80, maxHeight: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                if isCorrect != nil {
                    Button("Continue") {
                        nextWord()
                        translation(question: question)
                        isCorrect = nil
                    }
                    .font(.title)
                }
                Spacer()
                
                switch score {
                case 0..<5:
                    Hearts(quantity: 0)
                case 5..<10:
                    Hearts(quantity: 1)
                case 10..<15:
                    Hearts(quantity: 2)
                case 15..<20:
                    Hearts(quantity: 3)
                default:
                    Hearts(quantity: 0)
                }
                 
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
            }
            .onDisappear {
                save()
            }
            .onAppear {
                nextWord()
                translation(question: question)
            }
            .navigationBarTitle("Engish-Spanish Quiz")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                nextWord()
                translation(question: question)
                score = 0
            }, label: {
                Image(systemName: "hare.fill")
            }))
        }
    }
    
    func save() {
        UserDefaults.standard.setValue(score, forKey: "Score")
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
    
    func isCorrect(question: String, answer: String) {
        
        if dict[question] == answer {
            isCorrect = true
            score += 1
        } else {
            isCorrect = false
            
            switch score {
            case 0..<5:
                score -= 1
            case 6..<10:
                score -= 1
            case 11..<15:
                score -= 1
            case 16..<100:
                score -= 1
            default:
                break
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

