import Foundation
import SwiftUI

struct TicketItem: Identifiable, Equatable, Sendable {
    let id: UUID
    let number: Int
    let codeNumber: String
    let profit: Int
    let bearColor: Color
    var isOpened: Bool
}

struct TicketPage: Sendable {
    let items: [TicketItem]
    let totalCount: Int
    let lotteryTitle: String
}
