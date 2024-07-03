//
//  Gradient.swift
//  Flagquiz
//
//  Created by Caio on 26/06/24.
//

import SwiftUI

struct Gradient: View {
    var body: some View {
        ZStack {
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            
            LinearGradient(stops: [
                .init(color: .white, location: 0.45),
                .init(color: .gray, location: 0.55)
            ], startPoint: .leading, endPoint: .trailing).ignoresSafeArea().opacity(0.2)
            
            RadialGradient(colors: [.blue, .gray.opacity(0.02)], center: .center, startRadius: 5, endRadius: 500).ignoresSafeArea()
        }
    }
}

#Preview {
    Gradient()
}
