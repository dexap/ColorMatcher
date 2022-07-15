import SwiftUI

struct ContentView: View {
    @State var randomColors: [Double] = [0.0, 0.0, 0.0]
    @State var randomRed = Double.random(in: 0 ... 1)
    @State var randomGreen = Double.random(in: 0 ... 1)
    @State var randomBlue = Double.random(in: 0 ... 1)

    @State var userColors: [Double] = [0.0, 0.0, 0.0]
    @State var userRed = Double.random(in: 0 ... 1)
    @State var userGreen = Double.random(in: 0 ... 1)
    @State var userBlue = Double.random(in: 0 ... 1)

    let colorManager = ColorManager()
    @State var storage = Storage()
    @State private var isShowingAlert = false
    @State private var isShowingHighscores = false
    @State private var isShowingHelp = false
    @State private var isShowingDelete = false

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                // rechts
                Circle()
                    .frame(width: 150, height: 150)
                    .offset(x: 50)
                    .foregroundColor(Color(red: userRed, green: userGreen, blue: userBlue))

                // links
                Circle()
                    .frame(width: 150, height: 150)
                    .offset(x: -50)
                    .foregroundColor(Color(red: randomRed, green: randomGreen, blue: randomBlue))
            }
            .shadow(radius: 10)
            .padding(.bottom, 20)
            .padding(.top, -30)

            Spacer()

            HStack {
                VerticalSlider(color: .red, value: $userRed)
                VerticalSlider(color: .green, value: $userGreen)
                VerticalSlider(color: .blue, value: $userBlue)
            }

            Spacer()

            HStack {
                Spacer()
                Button("?") {
                    isShowingHelp = true
                }
                .frame(width: 50)
                .buttonStyle(.bordered)
                .controlSize(.mini)

                Spacer()

                Button("Hit me") {
                    userColors[0] = userRed
                    userColors[1] = userGreen
                    userColors[2] = userBlue

                    randomColors[0] = randomRed
                    randomColors[1] = randomGreen
                    randomColors[2] = randomBlue

                    colorManager.updateScore(userColors, randomColors)
                    storage.saveScore(colorManager.scoreRounded)

                    isShowingAlert = true
                }
                .buttonStyle(.bordered)
                .controlSize(.mini)
                .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
                .tint(Color(red: userRed, green: userGreen, blue: userBlue))
                .foregroundColor(.accentColor)
                .alert("Your Score is \(colorManager.scoreRounded)", isPresented: $isShowingAlert) {
                    Button("Try Again") {
                        randomRed = Double.random(in: 0 ... 1)
                        randomGreen = Double.random(in: 0 ... 1)
                        randomBlue = Double.random(in: 0 ... 1)
                    }
                    Button("Highscores") { isShowingHighscores = true }
                }

                Spacer()

                Button {
                    isShowingHighscores = true
                } label: {
                    Image(systemName: "list.number")
                }
                .frame(width: 50)
                .buttonStyle(.bordered)
                .controlSize(.mini)
                Spacer()
            }
            .padding(.horizontal)

            Spacer()
        }

        // Highscores Sheet
        .sheet(isPresented: $isShowingHighscores) {
            // Kopfleiste
            HStack {
                Text("Highscores")
                    .font(.title)
                    .bold()
                Spacer()

                Button {
                    isShowingDelete = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
                .buttonStyle(.bordered)
                .controlSize(.mini)
                .padding(.horizontal)
                .alert("Are you sure?", isPresented: $isShowingDelete) {
                    Button("Delete", role: .destructive) {
                        storage.deleteScores()
                        isShowingDelete = false
                        isShowingHighscores = false
                    }
                }

                Button {
                    isShowingHighscores = false
                } label: {
                    Label("", systemImage: "x.circle")
                }
                .padding(.trailing, -10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)

            let orderedSocres = storage.getScores().sorted(by: >)
            List(orderedSocres, id: \.self) { entry in
                Label {
                    Text(String(entry))
                } icon: {
                    switch orderedSocres.firstIndex(of: entry) {
                    case 0: Circle().foregroundColor(.yellow)
                    case 1: Circle().foregroundColor(.gray)
                    case 2: Circle().foregroundColor(.brown)
                    default: Circle().foregroundColor(.init(.sRGB, white: 0.8, opacity: 0.15))
                    }
                }
            }
            .padding(.top, -10)
        }
        .sheet(isPresented: $isShowingHelp) {
            Text("Try to match the color of the right circle to the color of the left Circle by draging the sliders.\n\nConfirm your coice with the \"HIT ME\"-Button!")
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color(.sRGB, white: 0.2, opacity: 0.2))
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
