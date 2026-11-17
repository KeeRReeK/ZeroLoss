import Foundation
import RealmSwift
import Realm
import Observation

@Observable
@MainActor
final class LotteryViewModel {
    var isGenerating: Bool = false
    var errorMessage: String? = nil
    var tickets: Results<VinniTicket>?
    /// A list of tickets opened during this session. Since `tickets` is a static
    /// snapshot, it's `isWinning` property does not update automatically until the next `loadTickets()` call.
    /// This set bridges that gap, ensuring the state is not lost.
    var openedTicketIDs: Set<UUID> = []
    
    func purchasing100kLotteryTickets() {
        guard !isGenerating else {
            return
        }
        isGenerating = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            
            do {
                let realm = try Realm()
                
                let lottery = Lottery()
                lottery.title = "VINNI"
                
                var newLottery: [VinniTicket] = []
                newLottery.reserveCapacity(100000)
                
                for i in 1...100000 {
                    let ticket = VinniTicket()
                    ticket.number = i
                    ticket.isWinning = false
                    ticket.profit = Int.random(in: 0...50)
                    ticket.codeNumber = "VINNI-\(Int.random(in: 10000...99999))"
                    ticket.bearColor = BearColor.allCases.randomElement()!.rawValue
                    newLottery.append(ticket)
                }
                
                try realm.write {
                    lottery.tickets.append(objectsIn: newLottery)
                    realm.add(lottery)
                }
                
                DispatchQueue.main.async {
                    self.isGenerating = false
                    self.loadTickets()
                }
            } catch {
                print("Error while saving: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isGenerating = false
                }
            }
        }
    }
    
    func loadTickets() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let realm = try Realm()
                let frozenTickets = realm.objects(VinniTicket.self)
                    .sorted(byKeyPath: "number", ascending: true)
                    .freeze()
                
                DispatchQueue.main.async {
                    self?.tickets = frozenTickets
                }
            } catch {
                print("Error while loading: \(error)")
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func isOpened(_ ticket: VinniTicket) -> Bool {
        ticket.isWinning || openedTicketIDs.contains(ticket.id)
    }

    func openTicket(_ ticket: VinniTicket) {
        guard !isOpened(ticket) else {
            return
        }
        let id = ticket.id
        let profit = ticket.profit

        // Update UI immediately; `tickets` is not replaced, so the List keeps its identity.
        openedTicketIDs.insert(id)
        BalanceStorage.add(profit)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let realm = try Realm()
                guard let liveTicket = realm.object(ofType: VinniTicket.self, forPrimaryKey: id) else {
                    return
                }
                try realm.write {
                    liveTicket.isWinning = true
                }
            } catch {
                print("Error while opening ticket: \(error)")
                DispatchQueue.main.async {
                    self?.openedTicketIDs.remove(id)
                    BalanceStorage.add(-profit)
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
