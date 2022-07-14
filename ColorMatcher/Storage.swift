//
//  Storage.swift
//  ColorMatcher
//
//  Created by Benjamin Lassmann on 13.07.22.
//

import Foundation

class Storage {
    private let userDefaults = UserDefaults.standard

    func saveScore(_ score: Int) {
        var scores: [Int] = userDefaults.object(forKey: "scores") as? [Int] ?? [Int]()
        scores.append(score)
        scores = Array(Set(scores))

        userDefaults.set(scores, forKey: "scores")
        userDefaults.synchronize()
        print(scores)
    }

    func getScores() -> [Int] {
        return userDefaults.object(forKey: "scores") as? [Int] ?? [Int]()
    }

    func deleteScores() {
        let empty: [Int] = []
        userDefaults.set(empty, forKey: "scores")
        userDefaults.synchronize()
    }
}
