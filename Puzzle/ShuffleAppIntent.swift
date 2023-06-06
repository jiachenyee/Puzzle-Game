//
//  ShuffleAppIntent.swift
//  Puzzle Game
//
//  Created by Jia Chen Yee on 6/6/23.
//

import Foundation
import AppIntents

struct ShuffleAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let values = [
            "topLeadingCurrentPosition",
            "topCurrentPosition",
            "topTrailingCurrentPosition",
            "leadingCurrentPosition",
            "centerCurrentPosition",
            "trailingCurrentPosition",
            "bottomLeadingCurrentPosition",
            "bottomCurrentPosition"
        ].shuffled()
        
        for (n, value) in values.enumerated() {
            store.setValue(Position(rawValue: n + 1)!.rawValue, forKey: value)
        }
        
        return .result()
    }
}
