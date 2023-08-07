//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alondra Rodríguez on 24/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    @State private var endGame = false
    @State private var counter = 0
    
    @State private var selectedFlag = -1

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: UnitPoint.bottom)
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            if counter <= 7 {
                                    flagTapped(number)
                            } else if counter > 7 {
                                    alertGameOver()
                            }
                        }
                        
                            label: {
                                FlagImage(name: countries[number])
                                    // I didn't add a new modifier
                            }
                    }
                    
                    
                    .padding()
                }
                
                
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            
            
            .alert(Text("Game Over"), isPresented: $endGame) {
                Button("Start a new game", action: newGame)
            } message: {
                Text("Your final score is \(score)")
            }
        }
    }
        
        
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 100
            } else {
                scoreTitle = "Wrong this is the flag of \(countries[number])"
                score -= 100
            }
            counter += 1
            print("Counter is: \(counter)")
            showingScore = true
        }
        
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
        func alertGameOver() {
            endGame = true
        }
        
        func newGame() {
            counter = 0
            score = 0
        }
        
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
