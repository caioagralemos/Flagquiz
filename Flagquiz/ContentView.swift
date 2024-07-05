//
//  ContentView.swift
//  Flagquiz
//
//  Created by Caio on 26/06/24.
//

import SwiftUI

var cities = [
    "São Miguel dos Milagres", "Jacuípe", "Limoeiro de Anadia", "Lagoa da Canoa", "Santa Luzia do Norte",
    "Quebrangulo", "Monteirópolis", "Chã Preta", "Batalha", "Poço das Trincheiras", "Junqueiro", "Arapiraca",
    "Paulo Jacinto", "São Sebastião", "Piaçabuçu", "São Luiz do Quitunde", "Colônia Leopoldina", "Porto Calvo",
    "Campo Alegre", "Major Isidoro", "São Miguel dos Campos", "Campo Grande", "Olho d'Água das Flores", "Jaramataia",
    "Porto Real do Colégio", "Igreja Nova", "Tanque d'Arca", "Jequiá da Praia", "Boca da Mata", "Piranhas", "Traipu",
    "Carneiros", "Olho d'Água Grande", "Mar Vermelho", "Olivença", "Maceió", "Jundiá", "Dois Riachos", "São José da Tapera",
    "Paripueira", "Matriz do Camaragibe", "Capela", "Taquarana", "Anadia", "Feliz Deserto", "Messias", "Canapi",
    "Joaquim Gomes", "Girau do Ponciano", "Jacaré dos Homens", "Murici", "Maragogi", "Barra de São Miguel",
    "Santana do Mundaú", "Inhapi", "Pilar", "Coqueiro Seco", "Coité do Nóia", "Cacimbinhas", "Campestre", "Roteiro",
    "Novo Lino", "Pindoba", "Pão de Açúcar", "Minador do Negrão", "Mata Grande", "Feira Grande", "Japaratinga", "Satuba",
    "Barra de Santo Antônio", "Flexeiras", "São Brás", "Rio Largo", "Marechal Deodoro", "Viçosa", "Palmeira dos Índios",
    "União dos Palmares", "Igaci", "Branquinha", "Olho d'Água do Casado", "Água Branca", "Teotônio Vilela", "Caraíbas",
    "Cajueiro", "Estrela de Alagoas", "Atalaia", "Maribondo", "Ibateguara", "Penedo", "Pariconha", "Ouro Branco",
    "Passo de Camaragibe", "Senador Rui Palmeira", "Palestina", "Coruripe", "Porto de Pedras", "Belo Monte", "Maravilha",
    "Belém", "São José da Laje", "Santana do Ipanema", "Delmiro Gouveia"
]

func getRandomNumbers(from range: ClosedRange<Int>, count: Int = 3) -> ([Int], Int) {
    guard range.count >= count else {
        return ([0,1,2], 0)
    }
    
    var numbers: Set<Int> = []
    
    while numbers.count != count {
        numbers.insert(Int.random(in: range))
    }
    
    return (Array(numbers), numbers.randomElement() ?? 0)
}

struct Flag: View {
    var image: String
    var opacity: Double
    var degrees: Double
    var scale: Double
    
    var body: some View {
        ZStack {
            Image(image).resizable().frame(width: 200, height: 100).cornerRadius(100).shadow(radius: 5).opacity(opacity).rotation3DEffect(
                .degrees(degrees), axis: (x: 0.0, y: 1.0, z: 0.0)
            ).scaleEffect(scale).animation(.easeInOut, value: opacity)
        }
    }
}

struct ContentView: View {
    @State private var randomCities: [Int] = []
    @State private var correctAnswer: Int = 0
    @State private var score = 0
    @State private var previousScore = 0
    @State private var round = 1
    @State private var showingAlert = false
    @State private var citiesDone: [Int] = []
    
    // animation
    @State private var opacityData: [Double] = [1, 1, 1]
    @State private var rotationData: [Double] = [0, 0, 0]
    @State private var scaleData: [Double] = [1, 1, 1]
    @State private var scoreColor = Color.white
    @State private var scoreEffect = 1.0
    
    init() {
        let (randomCities, correctAnswer) = getRandomNumbers(from: 0...cities.count-1, count: 3)
                _randomCities = State(initialValue: randomCities)
                _correctAnswer = State(initialValue: correctAnswer)
    }
    var body: some View {
        ZStack {
            Image("Alagoas").resizable().scaledToFill().ignoresSafeArea().blur(radius: 2)
            VStack {
                Text("\(round)/8").foregroundStyle(.white)
                Spacer()
                Text("Acerte a Bandeira").font(.largeTitle).bold().foregroundStyle(.white)
                
                VStack (spacing: 30) {
                    VStack (alignment: .center) {
                        Text("Toque na bandeira de").foregroundStyle(.primary)
                        Text("\(cities[correctAnswer])").foregroundStyle(.primary).bold().font(.largeTitle).multilineTextAlignment(.center).onTapGesture {
                            for i in randomCities {
                                print(cities[i])
                            }
                        }
                    }
                    
                    
                    ForEach (randomCities, id: \.self) { number in
                        let n = randomCities.firstIndex(of: number) ?? 0
                        Flag(image: "\(cities[number])", opacity: opacityData[n], degrees: rotationData[n], scale: scaleData[n]).onTapGesture {
                            flagTap(number: number)
                        }
                    }
                    
                    
                }.padding().frame(width: 300).background(.thinMaterial).cornerRadius(30).alert("Você fez \(score) pontos!", isPresented: $showingAlert) {
                    Button("Beleza") {                   round = 1
                        score = 0
                        citiesDone = []
                        newFlag()
                    }
                }
                
                Text("Pontos: \(score)").font(.title).bold().foregroundStyle(scoreColor).padding().scaleEffect(scoreEffect).animation(.easeInOut, value: scoreEffect)
                
                Spacer()
            }
        }
    }
    
    func flagTap(number: Int) {
        let n = randomCities.firstIndex(of: number) ?? 0
        if n == 0 {
            withAnimation(.easeInOut) {
                opacityData = [1, 0.25, 0.25]
                scaleData = [1.25, 0.75, 0.75]
                rotationData[n] += 360
            }
        } else if n == 1 {
            withAnimation(.easeInOut) {
                opacityData = [0.25, 1, 0.25]
                scaleData = [0.75, 1.25, 0.75]
                rotationData[n] += 360
            }
        } else {
            withAnimation(.easeInOut) {
                opacityData = [0.25, 0.25, 1]
                scaleData = [0.75, 0.75, 1.25]
                rotationData[n] += 360
            }
        }
        
        if number == correctAnswer {
            score += 10
            withAnimation {
                scoreColor = .green
                scoreEffect = 1.25
            }
        } else {
            if score >= 5 {
                score -= 5
            } else {
                score = 0
            }
            withAnimation {
                scoreColor = .red
                scoreEffect = 0.9
            }
        }
        if round != 8 {
            round += 1
            citiesDone.append(number)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // waits a second to run
                        newFlag()
                    }
        } else {
            showingAlert = true
        }
    }
    
    func newFlag() {
        (randomCities, correctAnswer) = getRandomNumbers(from: 0...cities.count-1, count: 3)
        while citiesDone.contains(correctAnswer) {
            (randomCities, correctAnswer) = getRandomNumbers(from: 0...cities.count-1, count: 3)
        }
        
        withAnimation {
            opacityData = [1,1,1]
            scaleData = [1,1,1]
            scoreColor = .white
            scoreEffect = 1.0
        }
    }
}

#Preview {
    ContentView()
}
