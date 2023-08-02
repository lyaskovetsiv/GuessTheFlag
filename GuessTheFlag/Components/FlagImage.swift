//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Иван Лясковец on 02.08.2023.
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
