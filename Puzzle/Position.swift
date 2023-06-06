//
//  Position.swift
//  Puzzle Game
//
//  Created by Jia Chen Yee on 6/6/23.
//

import Foundation
import SwiftUI

enum Position: Int, Equatable, Hashable, Codable {
    case topLeading = 1
    case top = 2
    case topTrailing = 3
    case leading = 4
    case center = 5
    case trailing = 6
    case bottomLeading = 7
    case bottom = 8
    case bottomTrailing = 9
    
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
