//
//  Enums.swift
//  Vertical Slider
//
//  Created by Benjamin Lassmann on 08.07.22.
//

import Foundation

enum RGB {
    case red
    case green
    case blue

    var string: String {
        switch self {
        case .red:
            return "red"
        case .green:
            return "green"
        case .blue:
            return "blue"
        }
    }

    var key: Int {
        switch self {
        case .red:
            return 0
        case .green:
            return 1
        case .blue:
            return 2
        }
    }
}
