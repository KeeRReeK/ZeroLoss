import RealmSwift
import Realm
import Foundation

class VinniTicket: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted(indexed: true) var number: Int = 0
    @Persisted var isWinning: Bool = false
    @Persisted var profit: Int = 0
    @Persisted var codeNumber: String = ""
    @Persisted var bearColor: String = ""
    
    @Persisted(originProperty: "tickets") var lottery: LinkingObjects<Lottery>
}
