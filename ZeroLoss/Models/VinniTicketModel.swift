import RealmSwift
import Foundation

class VinniTicket: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var number: Int = 0
    @Persisted var isWinning: Bool = false
    @Persisted var profit: Int = 0
    @Persisted var codeNumber: String = ""
    @Persisted var bearColor: String = ""
    
    @Persisted(originProperty: "tickets") var lottery: LinkingObjects<Lottery>
}
