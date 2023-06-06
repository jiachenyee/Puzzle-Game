//
//  Puzzle.swift
//  Puzzle
//
//  Created by Jia Chen Yee on 6/6/23.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let entry = SimpleEntry(date: .now, configuration: configuration)
        entries.append(entry)

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct PuzzleEntryView : View {
    var entry: Provider.Entry

    @State var hello = 0
    
    var emptySpot: Position {
        let allPositions: Set<Position> = [
            .topLeading, .top, .topTrailing,
            .leading, .center, .trailing,
            .bottomLeading, .bottom, .bottomTrailing
        ]
        
        return allPositions.subtracting([topLeadingCurrentPosition, topCurrentPosition, topTrailingCurrentPosition, leadingCurrentPosition, centerCurrentPosition, trailingCurrentPosition, bottomLeadingCurrentPosition, bottomCurrentPosition]).first!
    }
    
    @AppStorage("topLeadingCurrentPosition", store: .store) var topLeadingCurrentPosition = Position.topLeading
    @AppStorage("topCurrentPosition", store: .store) var topCurrentPosition = Position.top
    @AppStorage("topTrailingCurrentPosition", store: .store) var topTrailingCurrentPosition = Position.topTrailing
    @AppStorage("leadingCurrentPosition", store: .store) var leadingCurrentPosition = Position.leading
    @AppStorage("centerCurrentPosition", store: .store) var centerCurrentPosition = Position.center
    @AppStorage("trailingCurrentPosition", store: .store) var trailingCurrentPosition = Position.trailing
    @AppStorage("bottomLeadingCurrentPosition", store: .store) var bottomLeadingCurrentPosition = Position.bottomLeading
    @AppStorage("bottomCurrentPosition", store: .store) var bottomCurrentPosition = Position.bottom
    
    @AppStorage("isShuffling", store: .store) var isShuffling = false
    
    var body: some View {
        VStack {
            VStack {
                GeometryReader { reader in
                    let imageWidth = min(reader.size.width, reader.size.height)
                    
                    ZStack {
                        Button(intent: ShuffleAppIntent()) {
                            Rectangle()
                                .frame(width: imageWidth / 3, height: imageWidth / 3)
                                .opacity(0.01)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: emptySpot.toAlignment())
                        
                        ImageTileView(width: imageWidth,
                                      position: .topLeading,
                                      currentPosition: topLeadingCurrentPosition,
                                      intent: MoveTopLeading())
                        
                        ImageTileView(width: imageWidth,
                                      position: .top,
                                      currentPosition: topCurrentPosition,
                                      intent: MoveTop())
                        
                        ImageTileView(width: imageWidth,
                                      position: .topTrailing,
                                      currentPosition: topTrailingCurrentPosition,
                                      intent: MoveTopTrailing())
                        
                        ImageTileView(width: imageWidth,
                                      position: .leading,
                                      currentPosition: leadingCurrentPosition,
                                      intent: MoveLeading())
                        
                        ImageTileView(width: imageWidth,
                                      position: .center,
                                      currentPosition: centerCurrentPosition,
                                      intent: MoveCenter())
                        
                        ImageTileView(width: imageWidth,
                                      position: .trailing,
                                      currentPosition: trailingCurrentPosition,
                                      intent: MoveTrailing())
                        
                        ImageTileView(width: imageWidth,
                                      position: .bottomLeading,
                                      currentPosition: bottomLeadingCurrentPosition,
                                      intent: MoveBottomLeading())
                        
                        ImageTileView(width: imageWidth,
                                      position: .bottom,
                                      currentPosition: bottomCurrentPosition,
                                      intent: MoveBottom())
                        
                        ZStack {
                            HStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 1)
                            }
                            
                            VStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 1)
                                Spacer()
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 1)
                            }
                        }
                        .allowsHitTesting(false)
                    }
                    .frame(width: imageWidth, height: imageWidth)
                    .buttonStyle(.plain)
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct ImageTileView: View {
    
    var width: Double
    var position: Position
    
    var currentPosition: Position
    
    var intent: any AppIntent
    
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
                .allowsHitTesting(false)
            Button(intent: intent) {
                Rectangle()
                    .opacity(0.001)
                    .frame(width: width / 3, height: width / 3)
            }
        }
    }
}

struct Puzzle: Widget {
    let kind: String = "Puzzle"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PuzzleEntryView(entry: entry)
        }
    }
}

struct WidgetPreviewProvider: PreviewProvider {
    static var previews: some View {
        PuzzleEntryView(entry: .init(date: .now, configuration: .init()))
    }
}
