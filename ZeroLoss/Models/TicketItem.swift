import Foundation
import SwiftUI

nonisolated struct TicketItem: Identifiable, Equatable, Sendable {
    let id: UUID
    let number: Int
    let codeNumber: String
    let profit: Int
    let bearColor: Color
    var isOpened: Bool
}

nonisolated struct TicketPage: Sendable {
    let items: [TicketItem]
    let totalCount: Int
    let lotteryTitle: String
}
