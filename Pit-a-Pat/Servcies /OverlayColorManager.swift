//
//  File.swift
//  Pit-a-Pat
//
//  Created by Gehad Eid on 06/02/2024.
//

import SwiftUI
import Combine

class OverlayColorManager: ObservableObject {
//    @Published var color: Color = .clear // Start with a clear overlay
    @Published var textColor: Color = .white
        @Published var textOpacity: Double = 1.0
}
