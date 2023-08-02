//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Иван Лясковец on 20.07.2023.
//

import SwiftUI


struct ContentView: View {
	
	// MARK: - States
	
	@State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var isShowingEndOfGame = false
	@State private var isShowingScore = false
	@State private var scoreTitle = ""
	@State private var userScore = 0
	@State private var round = 0
	
	// MARK: - UI
	
	var body: some View {
		ZStack {
			RadialGradient(stops: [.init(color: Color(red: 0, green: 0.2, blue: 0.45), location: 0.4),
								   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.6)],
						   center: .top, startRadius: 200, endRadius: 700)
			VStack {
				Spacer()
				
				Text("Guess the Flag")
					.modifireBlueTitle()
				
				VStack (spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.foregroundStyle(.secondary)
							.font(.subheadline.weight(.heavy))
						
						Text(contries[correctAnswer])
							.font(.largeTitle.weight(.bold))
					}
					
					ForEach(0..<3) { number in
						Button {
							flagTapped(number: number)
						} label: {
							FlagImage(title: contries[number])
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				
				Spacer()
				
				Text("Score: \(userScore)")
					.foregroundColor(.white)
					.font(.title.bold())
				
				Spacer()
			}
			.padding()
			.alert(scoreTitle, isPresented: $isShowingScore) {
				Button("Continue", action: askQuestion)
			} message: {
				if scoreTitle == "Wrong" {
					Text("That’s the flag of \(contries[correctAnswer])")
				} else {
					Text("You are awesome!")
				}
			}
			.alert("THE END", isPresented: $isShowingEndOfGame) {
				Button("Try again!", action: reset)
			} message: {
				Text("Your score: \(userScore)")
			}
		}
		.ignoresSafeArea()
	}
}

// MARK: - Private methods

extension ContentView {
	private func flagTapped(number: Int) {
		if round == 10 {
			isShowingEndOfGame = true
		} else {
			round += 1
			if number == correctAnswer {
				scoreTitle = "RIGHT!"
				userScore += 1
			} else {
				scoreTitle = "WRONG :("
				userScore -= 1
			}
			isShowingScore = true
		}
	}
	
	private func askQuestion() {
		contries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
	
	private func reset() {
		round = 0
		userScore = 0
		scoreTitle = ""
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
