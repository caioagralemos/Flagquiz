//
//  Images.swift
//  Flagquiz
//
//  Created by Caio on 27/06/24.
//

import SwiftUI

struct Images: View {
    @State private var showingAlert = false
    var body: some View {
        // use decorative for voiceover to ignore the image
        Image(decorative: "hello").resizable().scaledToFit()
        Button("Edit", systemImage: "pencil") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    Images()
}
