import SwiftUI

struct VerticalSlider: View {
    var viewHeight = 140.0
    let color: Color
    @Binding var value: Double
    @State var isDragging = false

    var drag: some Gesture {
        DragGesture()
            .onChanged { dragValue in
                let realtivePosition = (dragValue.location.y / viewHeight)
                if realtivePosition >= 0.0 && realtivePosition <= 1.0 {
                    value = realtivePosition
                }
                self.isDragging = true
            }
            .onEnded { _ in
                self.isDragging = false
            }
    }

    var body: some View {
        VStack {
            Button("+") {
                if value.toRange() < 255 {
                    value += 1 / 256
                }
            }
            .foregroundColor(color)
            .buttonStyle(.bordered)
            .tint(color)

            ZStack {
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 2, height: viewHeight)
                    .foregroundColor(color)
                Circle()
                    .stroke()
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .position(x: 25, y: value * viewHeight)
                Circle()
                    .frame(width: 20, height: 20)
                    .position(x: 25, y: value * viewHeight)
                    .foregroundColor(color)
                    .shadow(radius: 6, x: 1, y: 1)
                    .gesture(drag)
            }
            .frame(width: 50, height: viewHeight, alignment: .center)
            .rotationEffect(.degrees(180))
            .padding()

            Button("-") {
                if value > 0 {
                    value -= 1 / 256
                }
            }.foregroundColor(color)
                .buttonStyle(.bordered)
                .tint(color)

            Text("\(value.toRange())")
                .bold()
                .padding(.top, 10)
        }
        .frame(width: 70)
    }
}

struct VerticalSlider_Previews: PreviewProvider {
    @State static var sliderValue = Double.random(in: 0 ... 1)
    static var previews: some View {
        HStack {
            VerticalSlider(color: .red, value: $sliderValue)
            VerticalSlider(color: .green, value: $sliderValue)
            VerticalSlider(color: .blue, value: $sliderValue)
        }
    }
}
