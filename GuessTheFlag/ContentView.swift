//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Иван Лясковец on 20.07.2023.
//

import SwiftUI

struct FlagImage: View {
	var title: String
	
	var body: some View {
		Image(title)
			.renderingMode(.original)
			.clipShape(Capsule())
			.shadow(radius: 5)
	}
}

struct BlueTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.foregroundColor(.blue)
	}
}

extension View {
	func modifireBlueTitle() -> some View {
		modifier(BlueTitle())
	}
}

struct ContentView: View {
	
	@State private var showingEndOfGame = false
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var userScore = 0
	@State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	@State private var count = 0
	
	var body: some View {
		ZStack {
			RadialGradient(stops: [.init(color: Color(red: 0, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
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
			.alert(scoreTitle, isPresented: $showingScore) {
				Button("Continue", action: askQuestion)
			} message: {
				if scoreTitle == "Wrong" {
					Text("Wrong! That’s the flag of \(contries[correctAnswer])")
				} else {
					Text("Correct! Your score is: \(userScore)")
				}
			}
			.alert("Game is over", isPresented: $showingEndOfGame) {
				Button("Reset", action: reset)
			} message: {
				Text("Your score is: \(userScore)")
			}

		}
		.ignoresSafeArea()
	}
	
	private func flagTapped(number: Int) {
		if count == 2 {
			showingEndOfGame = true
		} else {
			count += 1
			if number == correctAnswer {
				scoreTitle = "Right"
				userScore += 1
			} else {
				scoreTitle = "Wrong"
				userScore -= 1
			}
			showingScore = true
		}
	}
	
	private func askQuestion() {
		contries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
	
	private func reset() {
		count = 0
		userScore = 0
		scoreTitle = ""
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
