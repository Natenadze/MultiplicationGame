//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Davit Natenadze on 09.06.23.
//

import SwiftUI

struct ContentView: View {
    @State private var availableRounds = [5,10,15,20]
    
    @State private var tableToPractice = 0
    @State private var selectedRound = 5
    @State private var currentRound = 1
    @State private var showAlert = false
    @State private var correctAnswers = 0
    
    
    @State private var numberToMultiply = 1
    @State private var userAnswer = ""
    
    
    var body: some View {
        
        ZStack {
            Color.cyan
            
            Form {
                
                Section {
                    Picker("What number to practice?", selection: $tableToPractice) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Choose your table")
                        .foregroundColor(.white)
                        .font(.system(.headline))
                }
                
                //
                Section {
                    Picker("How many rounds", selection: $selectedRound) {
                        ForEach(availableRounds, id: \.self) { round in
                            Text("\(round)")
                        }
                    }
                } header: {
                    Text("Rounds")
                        .foregroundColor(.white)
                        .font(.system(.headline))
                }
                
                Section {
                    Button("Start Game") {
                        startOver()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                }
                
                Section {
                    Text("Round \(currentRound) 0f \(selectedRound)")
                        .frame(maxWidth: .infinity)
                        .font(.system(.title))
                        .padding(.horizontal, 60)
                }
                
                
                //
                Text("What is \(tableToPractice + 2) x \(numberToMultiply)")
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                    .padding(.horizontal, 60)
                    .font(.title)
                
                
                //
                TextField("Type your answer", text: $userAnswer)
                    .font(.title)
                    .multilineTextAlignment(.center) // Center-align the text field
                    .padding()
                
                //
                Button("Check answer") {
                    checkAnswer(with: Int(userAnswer) ?? 0)
                    nextQuestion()
                }
                .disabled(userAnswer.isEmpty ? true : false)
                .frame(maxWidth: .infinity)
                .padding()
                .font(.system(size: 23))
                .foregroundColor(.white)
                .background(userAnswer.isEmpty ? Color.gray : Color.red)
                .cornerRadius(10)
                .padding(.horizontal, 60)
                
            }
            .scrollContentBackground(.hidden)
            .alert("Game Over", isPresented: $showAlert) {
                Button("New Game", action: startOver)
            } message: {
                // TODO: - give correct score
                Text("Your score is \(correctAnswers) out of \(selectedRound)")
            }
            
        }
        
    }
    
    
    
    
    // MARK: - Methods
    
    // TODO: - Refactor
    func startOver() {
        correctAnswers = 0
        currentRound = 1
        userAnswer = ""
        numberToMultiply = Int.random(in: 1...12)
    }
    
    func nextQuestion() {
        if currentRound == selectedRound {
            showAlert.toggle()
        } else {
            currentRound += 1
        }
        userAnswer = ""
        numberToMultiply = Int.random(in: 1...12)
    }
    
    //
    func checkAnswer(with answer: Int) {
        let correctAnswer = (tableToPractice + 2) * numberToMultiply
        
        if answer == correctAnswer {
            correctAnswers += 1
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
