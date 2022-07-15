import Foundation

class ColorManager: ObservableObject {
    var score: Double = 0
    var scoreRounded: Int = 0

    func updateScore(_ userColors: [Double], _ randomColors: [Double]) {
        var differences: [Double] = []
        let redDiff = abs(userColors[0] - randomColors[0])
        let greenDiff = abs(userColors[1] - randomColors[1])
        let blueDiff = abs(userColors[2] - randomColors[2])

        differences.append(redDiff)
        differences.append(greenDiff)
        differences.append(blueDiff)

        print("userColors   = \(userColors)")
        print("randomColors = \(randomColors)")
        print("differences  = \(differences)")

        let difference = differences.sum() / 3 * 100
        print("difference   = \(difference)")
        score = (difference - 100) * -1
        scoreRounded = Int((difference - 100) * -1) + 1
        print("score        = \(score)")
        print("scoreRounded = \(scoreRounded)")
    }
}
