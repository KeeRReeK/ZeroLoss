import RealmSwift
import Foundation

class Lottery: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String = ""
    
    @Persisted var tickets: List<VinniTicket> = List<VinniTicket>()
}
