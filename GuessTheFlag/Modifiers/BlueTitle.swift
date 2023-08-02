//
//  BlueTitle.swift
//  GuessTheFlag
//
//  Created by Иван Лясковец on 02.08.2023.
//

import Foundation
import SwiftUI

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
