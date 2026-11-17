import Foundation
import RealmSwift
import Realm
import Observation

@Observable
@MainActor
final class LotteryViewModel {
    var isGenerating: Bool = false
    var errorMessage: String? = nil
    
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
                lottery.title = "Vinni"
                
                var newLottery: [VinniTicket] = []
                newLottery.reserveCapacity(100000)
                
                let colors = ["Red", "Blue", "Green", "Yellow"]
                
                for i in 1...100000 {
                    let ticket = VinniTicket()
                    ticket.number = i
                    ticket.isWinning = Bool.random()
                    ticket.profit = Int.random(in: 0...50)
                    ticket.codeNumber = "VINNI-\(Int.random(in: 10000...99999))"
                    ticket.bearColor = colors.randomElement()!
                    newLottery.append(ticket)
                }
                
                try realm.write {
                    lottery.tickets.append(objectsIn: newLottery)
                    realm.add(lottery)
                }
                
                DispatchQueue.main.async {
                    self.isGenerating = false
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
}
