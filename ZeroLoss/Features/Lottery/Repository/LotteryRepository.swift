import Foundation
import RealmSwift
import SwiftUI

struct LotteryRepository: Sendable {
    
    func fetchPage(offset: Int, limit: Int) throws -> TicketPage {
        let realm = try Realm()
        
        let results = realm.objects(VinniTicket.self)
            .sorted(byKeyPath: "number", ascending: true)
        
        let totalCount = results.count
        let lotteryTitle = realm.objects(Lottery.self).first?.title.uppercased() ?? "VINNI"
        
        guard offset < totalCount else {
            return TicketPage(items: [], totalCount: totalCount, lotteryTitle: lotteryTitle)
        }
        
        let end = min(offset + limit, totalCount)
        var items: [TicketItem] = []
        items.reserveCapacity(end - offset)
        
        for index in offset..<end {
            let ticket = results[index]
            items.append(
                TicketItem(
                    id: ticket.id,
                    number: ticket.number,
                    codeNumber: ticket.codeNumber,
                    profit: ticket.profit,
                    bearColor: BearColor(rawValue: ticket.bearColor)?.color ?? .gray,
                    isOpened: ticket.isWinning
                )
            )
        }
        
        return TicketPage(items: items, totalCount: totalCount, lotteryTitle: lotteryTitle)
    }
    
    func openTicket(id: UUID) throws {
        let realm = try Realm()
        guard let ticket = realm.object(ofType: VinniTicket.self, forPrimaryKey: id) else {
            return
        }
        try realm.write {
            ticket.isWinning = true
        }
    }
    
    func generateTickets(count: Int = 100000) throws {
        let realm = try Realm()
        
        let lottery = Lottery()
        lottery.title = "VINNI"
        
        var tickets: [VinniTicket] = []
        tickets.reserveCapacity(count)
        
        for number in 1...count {
            let ticket = VinniTicket()
            ticket.number = number
            ticket.isWinning = false
            ticket.profit = Int.random(in: 0...50)
            ticket.codeNumber = "VINNI-\(Int.random(in: 10000...99999))"
            ticket.bearColor = BearColor.allCases.randomElement()!.rawValue
            tickets.append(ticket)
        }
        
        try realm.write {
            lottery.tickets.append(objectsIn: tickets)
            realm.add(lottery)
        }
    }
}
