//
//  ContentView.swift
//  ColorMatcher
//
//  Created by Benjamin Lassmann on 13.07.22.
//

import SwiftUI

struct ContentView: View {
    @State var randomColors: [Double] = [0.0, 0.0, 0.0]
    let randomRed = Double.random(in: 0 ... 1)
    let randomGreen = Double.random(in: 0 ... 1)
    let randomBlue = Double.random(in: 0 ... 1)

    @State var userColors: [Double] = [0.0, 0.0, 0.0]
    @State var userRed = Double.random(in: 0 ... 1)
    @State var userGreen = Double.random(in: 0 ... 1)
    @State var userBlue = Double.random(in: 0 ... 1)

    let colorManager = ColorManager()
    let storage = Storage()
    @State private var isShowingAlert = false




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

            HStack {
                VerticalSlider(color: .red, value: $userRed)
                VerticalSlider(color: .green, value: $userGreen)
                VerticalSlider(color: .blue, value: $userBlue)
            }

            Button("Hit Me") {
                userColors[0] = userRed
                userColors[1] = userGreen
                userColors[2] = userBlue

                randomColors[0] = randomRed
                randomColors[1] = randomGreen
                randomColors[2] = randomBlue

                colorManager.updateScore(userColors, randomColors)

                isShowingAlert = true

            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .confirmationDialog("Your Score is \(colorManager.scoreRounded)", isPresented: $isShowingAlert, titleVisibility: .visible)
            {
                Button("Save", role: .none) { storage.saveScore(colorManager.scoreRounded) }
                Button("Cancel", role: .cancel) { print("Delete Tapped") }
                    .tint(.red)
            }

            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
