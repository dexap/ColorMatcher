
import Foundation
import SwiftUI

struct RGB {
    let random: Color =
        .init(red: Double.random(in: 0 ... 1),
              green: Double.random(in: 0 ... 1),
              blue: Double.random(in: 0 ... 1))
}
