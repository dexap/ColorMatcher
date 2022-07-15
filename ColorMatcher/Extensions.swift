import Foundation

extension Double {
    func toRange() -> Int {
        return Int(self * 255)
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}
