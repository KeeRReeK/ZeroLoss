import SwiftUI

enum BearColor: String, CaseIterable {
    case red = "Red", blue = "Blue", green = "Green", orange = "Orange"

    var color: Color {
        switch self {
        case .red: .red
        case .blue: .blue
        case .green: .green
        case .orange: .orange
        }
    }
}

extension VinniTicket {
    var bearSwiftUIColor: Color {
        BearColor(rawValue: bearColor)?.color ?? .gray
    }
}
