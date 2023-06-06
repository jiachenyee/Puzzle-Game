//
//  ContentView.swift
//  Puzzle Game
//
//  Created by Jia Chen Yee on 6/6/23.
//

import SwiftUI

enum Position: Equatable, Hashable {
    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing
    
    init(horizontal: HorizontalPosition, vertical: VerticalPosition) {
        switch vertical {
        case .top:
            switch horizontal {
            case .leading:
                self = .topLeading
            case .center:
                self = .top
            case .trailing:
                self = .topTrailing
            }
        case .center:
            switch horizontal {
            case .leading:
                self = .leading
            case .center:
                self = .center
            case .trailing:
                self = .trailing
            }
        case .bottom:
            switch horizontal {
            case .leading:
                self = .bottomLeading
            case .center:
                self = .bottom
            case .trailing:
                self = .bottomTrailing
            }
        }
    }
    
    init?(horizontal: HorizontalPosition?, vertical: VerticalPosition?) {
        guard let horizontal, let vertical else {
            return nil
        }
        switch vertical {
        case .top:
            switch horizontal {
            case .leading:
                self = .topLeading
            case .center:
                self = .top
            case .trailing:
                self = .topTrailing
            }
        case .center:
            switch horizontal {
            case .leading:
                self = .leading
            case .center:
                self = .center
            case .trailing:
                self = .trailing
            }
        case .bottom:
            switch horizontal {
            case .leading:
                self = .bottomLeading
            case .center:
                self = .bottom
            case .trailing:
                self = .bottomTrailing
            }
        }
    }
    
    var horizontal: HorizontalPosition {
        switch self {
        case .topLeading, .leading, .bottomLeading:
            return .leading
        case .top, .center, .bottom:
            return .center
        case .topTrailing, .trailing, .bottomTrailing:
            return .trailing
        }
    }
    
    var vertical: VerticalPosition {
        switch self {
        case .topLeading, .top, .topTrailing:
            return .top
        case .leading, .center, .trailing:
            return .center
        case .bottomLeading, .bottom, .bottomTrailing:
            return .bottom
        }
    }
    
    enum HorizontalPosition: Int {
        case leading
        case center
        case trailing
    }
    
    enum VerticalPosition: Int {
        case top
        case center
        case bottom
    }
    
    func toAlignment() -> Alignment {
        switch self {
        case .topLeading:
            return .topLeading
        case .top:
            return .top
        case .topTrailing:
            return .topTrailing
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .bottomLeading:
            return .bottomLeading
        case .bottom:
            return .bottom
        case .bottomTrailing:
            return .bottomTrailing
        }
    }
}

struct ContentView: View {
    
    var emptySpot: Position {
        let allPositions: Set<Position> = [
            .topLeading, .top, .topTrailing,
            .leading, .center, .trailing,
            .bottomLeading, .bottom, .bottomTrailing
        ]
         
        return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
    }
    
    @State private var topLeadingCurrentPosition = Position.topLeading
    @State private var topCurrentPosition = Position.top
    @State private var topTrailingCurrentPosition = Position.topTrailing
    @State private var leadingCurrentPosition = Position.leading
    @State private var centerCurrentPosition = Position.center
    @State private var trailingCurrentPosition = Position.trailing
    @State private var bottomLeadingCurrentPosition = Position.bottomLeading
    @State private var bottomCurrentPosition = Position.bottom
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect()
    
    @State private var lastShuffleMovement: Position?
    @State private var isShuffling = false
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                let imageWidth = min(reader.size.width, reader.size.height)
                
                ZStack {
                    Button {
                        lastShuffleMovement = nil
                        isShuffling.toggle()
                    } label: {
                        Rectangle()
                            .frame(width: imageWidth / 3, height: imageWidth / 3)
                            .opacity(0.01)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: emptySpot.toAlignment())
                    
                    ImageTileView(width: imageWidth, position: .topLeading, currentPosition: topLeadingCurrentPosition) {
                        disableShuffle()
                        move(position: .topLeading)
                    }
                    ImageTileView(width: imageWidth, position: .top, currentPosition: topCurrentPosition) {
                        disableShuffle()
                        move(position: .top)
                    }
                    ImageTileView(width: imageWidth, position: .topTrailing, currentPosition: topTrailingCurrentPosition) {
                        disableShuffle()
                        move(position: .topTrailing)
                    }
                    ImageTileView(width: imageWidth, position: .leading, currentPosition: leadingCurrentPosition) {
                        disableShuffle()
                        move(position: .leading)
                    }
                    ImageTileView(width: imageWidth, position: .center, currentPosition: centerCurrentPosition) {
                        disableShuffle()
                        move(position: .center)
                    }
                    ImageTileView(width: imageWidth, position: .trailing, currentPosition: trailingCurrentPosition) {
                        disableShuffle()
                        move(position: .trailing)
                    }
                    ImageTileView(width: imageWidth, position: .bottomLeading, currentPosition: bottomLeadingCurrentPosition) {
                        disableShuffle()
                        move(position: .bottomLeading)
                    }
                    ImageTileView(width: imageWidth, position: .bottom, currentPosition: bottomCurrentPosition) {
                        disableShuffle()
                        move(position: .bottom)
                    }
                }
                .buttonStyle(.plain)
                .frame(width: imageWidth, height: imageWidth)
                .onReceive(timer) { _ in
                    if isShuffling {
                        shuffle()
                    }
                }
            }
        }
        .padding()
    }
    
    func disableShuffle() {
        lastShuffleMovement = nil
        isShuffling = false
    }
    
    func shuffle() {
        let actualPositions: [Position] = getMovablePositions()
            .map { currentPosition in
                let actualImagePosition: Position
                
                if topLeadingCurrentPosition == currentPosition {
                    actualImagePosition = .topLeading
                } else if topCurrentPosition == currentPosition {
                    actualImagePosition = .top
                } else if topTrailingCurrentPosition == currentPosition {
                    actualImagePosition = .topTrailing
                } else if leadingCurrentPosition == currentPosition {
                    actualImagePosition = .leading
                } else if centerCurrentPosition == currentPosition {
                    actualImagePosition = .center
                } else if trailingCurrentPosition == currentPosition {
                    actualImagePosition = .trailing
                } else if bottomLeadingCurrentPosition == currentPosition {
                    actualImagePosition = .bottomLeading
                } else if bottomCurrentPosition == currentPosition {
                    actualImagePosition = .bottom
                } else {
                    fatalError()
                }
                
                return actualImagePosition
            }
            
        let selectedPosition = actualPositions.filter {
            $0 != lastShuffleMovement
        }
            .randomElement()!
        
        move(position: selectedPosition)
        
        lastShuffleMovement = selectedPosition
    }
    
    @discardableResult
    func move(position: Position) -> Bool {
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
        
        guard canMove(position: currentPosition) else { return false }
        
        withAnimation {
            switch position {
            case .topLeading:
                topLeadingCurrentPosition = emptySpot
            case .top:
                topCurrentPosition = emptySpot
            case .topTrailing:
                topTrailingCurrentPosition = emptySpot
            case .leading:
                leadingCurrentPosition = emptySpot
            case .center:
                centerCurrentPosition = emptySpot
            case .trailing:
                trailingCurrentPosition = emptySpot
            case .bottomLeading:
                bottomLeadingCurrentPosition = emptySpot
            case .bottom:
                bottomCurrentPosition = emptySpot
            case .bottomTrailing:
                print("WHAT")
            }
            
        }
        
        return true
    }
    
    func canMove(position: Position) -> Bool {
        return getMovablePositions().contains(position)
    }
    
    func getMovablePositions() -> [Position] {
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

struct ImageTileView: View {
    
    var width: Double
    var position: Position
    
    var currentPosition: Position
    
    var onAction: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: currentPosition.toAlignment()) {
            Image("Image")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: width)
                .mask(alignment: position.toAlignment()) {
                    Rectangle()
                        .frame(width: width / 3, height: width / 3)
                }
                .offset(x: {
                    switch currentPosition.horizontal {
                    case .leading:
                        if position.horizontal == .leading {
                            return 0
                        } else if position.horizontal == .trailing {
                            return -width / 3 * 2
                        } else {
                            return -width / 3
                        }
                    case .trailing:
                        if position.horizontal == .leading {
                            return width / 3 * 2
                        } else if position.horizontal == .trailing {
                            return 0
                        } else {
                            return width / 3
                        }
                    default:
                        if position.horizontal == .leading {
                            return width / 3
                        } else if position.horizontal == .center {
                            return 0
                        } else {
                            return -width / 3
                        }
                    }
                }(), y: {
                    switch currentPosition.vertical {
                    case .top:
                        if position.vertical == .top {
                            return 0
                        } else if position.vertical == .bottom {
                            return -width / 3 * 2
                        } else {
                            return -width / 3
                        }
                    case .bottom:
                        if position.vertical == .top {
                            return width / 3 * 2
                        } else if position.vertical == .bottom {
                            return 0
                        } else {
                            return width / 3
                        }
                    default:
                        if position.vertical == .top {
                            return width / 3
                        } else if position.vertical == .center {
                            return 0
                        } else {
                            return -width / 3
                        }
                    }
                }())
                .overlay(alignment: currentPosition.toAlignment()) {
                    Rectangle()
                        .stroke(lineWidth: 3)
                        .frame(width: width / 3, height: width / 3)
                }
                .allowsHitTesting(false)
            Button {
                onAction?()
            } label: {
                Rectangle()
                    .opacity(0.001)
                    .frame(width: width / 3, height: width / 3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
