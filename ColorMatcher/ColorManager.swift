import Foundation

class ColorManager {
    private var score: Double?

    var roundedScore: Int {
        guard let score = score else {
            print("Calculating Score failed")
            return 0
        }
        return Int(score.rounded(.toNearestOrEven))
    }

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
        print("score        = \(score ?? 0.0)")
        print("scoreRounded = \(roundedScore)")
    }
}
