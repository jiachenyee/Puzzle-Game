//
//  MoveAppIntents.swift
//  Puzzle Game
//
//  Created by Jia Chen Yee on 6/6/23.
//

import Foundation
import AppIntents

struct MoveTopLeading: AppIntent {
    let position: Position = .topLeading
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveTop: AppIntent {
    let position: Position = .top
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveTopTrailing: AppIntent {
    let position: Position = .topTrailing
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition"))  ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition"))  ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition"))  ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition"))  ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition"))  ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition"))  ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition"))  ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition"))  ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveLeading: AppIntent {
    let position: Position = .leading
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition"))  ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition"))  ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition"))  ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition"))  ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition"))  ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition"))  ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition"))  ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition"))  ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveCenter: AppIntent {
    let position: Position = .center
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveTrailing: AppIntent {
    let position: Position = .trailing
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveBottomLeading: AppIntent {
    let position: Position = .bottomLeading
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveBottom: AppIntent {
    let position: Position = .bottom
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}

struct MoveBottomTrailing: AppIntent {
    let position: Position = .bottomTrailing
    
    static var title: LocalizedStringResource = "Move tile"
    static var description = IntentDescription("Move certain tiles.")
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.store
        
        let topLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "topLeadingCurrentPosition")) ?? .topLeading
        let topCurrentPosition = Position(rawValue: store.integer(forKey: "topCurrentPosition")) ?? .top
        let topTrailingCurrentPosition = Position(rawValue: store.integer(forKey: "topTrailingCurrentPosition")) ?? .topTrailing
        let leadingCurrentPosition = Position(rawValue: store.integer(forKey: "leadingCurrentPosition")) ?? .leading
        let centerCurrentPosition = Position(rawValue: store.integer(forKey: "centerCurrentPosition")) ?? .center
        let trailingCurrentPosition = Position(rawValue: store.integer(forKey: "trailingCurrentPosition")) ?? .trailing
        let bottomLeadingCurrentPosition = Position(rawValue: store.integer(forKey: "bottomLeadingCurrentPosition")) ?? .bottomLeading
        let bottomCurrentPosition = Position(rawValue: store.integer(forKey: "bottomCurrentPosition")) ?? .bottom
        
        let emptySpot: Position = {
            let allPositions: Set<Position> = [
                .topLeading, .top, .topTrailing,
                .leading, .center, .trailing,
                .bottomLeading, .bottom, .bottomTrailing
            ]
            
            return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
        }()
        
        let currentPosition: Position
        switch position {
        case .topLeading:
            currentPosition = topLeadingCurrentPosition
        case .top:
            currentPosition = topCurrentPosition
        case .topTrailing:
            currentPosition = topTrailingCurrentPosition
        case .leading:
            currentPosition = leadingCurrentPosition
        case .center:
            currentPosition = centerCurrentPosition
        case .trailing:
            currentPosition = trailingCurrentPosition
        case .bottomLeading:
            currentPosition = bottomLeadingCurrentPosition
        case .bottom:
            currentPosition = bottomCurrentPosition
        default:
            fatalError()
        }
        
        guard canMove(position: currentPosition, emptySpot: emptySpot) else { return .result() }
        
        switch position {
        case .topLeading:
            store.setValue(emptySpot.rawValue, forKey: "topLeadingCurrentPosition")
        case .top:
            store.setValue(emptySpot.rawValue, forKey: "topCurrentPosition")
        case .topTrailing:
            store.setValue(emptySpot.rawValue, forKey: "topTrailingCurrentPosition")
        case .leading:
            store.setValue(emptySpot.rawValue, forKey: "leadingCurrentPosition")
        case .center:
            store.setValue(emptySpot.rawValue, forKey: "centerCurrentPosition")
        case .trailing:
            store.setValue(emptySpot.rawValue, forKey: "trailingCurrentPosition")
        case .bottomLeading:
            store.setValue(emptySpot.rawValue, forKey: "bottomLeadingCurrentPosition")
        case .bottom:
            store.setValue(emptySpot.rawValue, forKey: "bottomCurrentPosition")
        case .bottomTrailing:
            print("WHAT")
        }
        
        store.setValue(false, forKey: "isShuffling")
        
        return .result()
    }
    
    func canMove(position: Position, emptySpot: Position) -> Bool {
        return getMovablePositions(from: emptySpot).contains(position)
    }
    
    func getMovablePositions(from emptySpot: Position) -> [Position] {
        return [
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue - 1)),
            Position(horizontal: emptySpot.horizontal,
                     vertical: .init(rawValue: emptySpot.vertical.rawValue + 1)),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue - 1),
                     vertical: emptySpot.vertical),
            Position(horizontal: .init(rawValue: emptySpot.horizontal.rawValue + 1),
                     vertical: emptySpot.vertical)
        ].compactMap { $0 }
    }
}
