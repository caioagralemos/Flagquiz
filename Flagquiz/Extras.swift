//
//  Extras.swift
//  Flagquiz
//
//  Created by Caio on 26/06/24.
//

import SwiftUI

struct Extras: View {
    @State var text = ""
    var body: some View {
        // spacing, alignment
        ZStack {
            VStack {
                Color.red.ignoresSafeArea().opacity(0.2)
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.yellow.gradient)
            
            Color.white.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 180).padding(.top)
            VStack(alignment: .center) {
                Spacer()
                
                Text("Olá, Mundo!")
                Text("Como você vai? Tá tudo bem?")
                HStack(spacing: 20) {
                    Text("Você pode escrever o que quiser!")
                    Image(systemName: "pencil")
                }
                
                Spacer()
                VStack(alignment: .center) {
                    HStack {
                        ForEach (1..<4) { i in
                            Button("\(i)") {
                                print(i)
                            }.font(.largeTitle)
                        }
                    }
                    HStack {
                        ForEach (4..<7) { i in
                            Button("\(i)") {
                                print(i)
                            }.font(.largeTitle)
                        }
                    }
                    HStack {
                        ForEach (7..<10) { i in
                            Button("\(i)") {
                                print(i)
                            }.font(.largeTitle)
                        }
                    }
                }
                Spacer()
                
                HStack {
                    Button("Button 1") { }
                        .buttonStyle(.bordered)
                    Button("Button 2", role: .destructive) { }
                        .buttonStyle(.bordered)
                    Button("Button 3") { }
                        .buttonStyle(.borderedProminent).tint(.brown)
                    Button("Button 4", role: .destructive) { }
                        .buttonStyle(.borderedProminent)
                }
                
                // custom button
                Button {
                    print("tap!")
                } label: {
                    Text("do not tap me!".uppercased()).bold()
                        .padding().foregroundStyle(.white).background(.red.gradient).cornerRadius(15)
                }
                
                Spacer()
            }//.background(.ultraThinMaterial) // backgrounds
        }
    }
}

#Preview {
    Extras()
}
