import RealmSwift
import Realm
import Foundation

class Lottery: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String = ""
    
    @Persisted var tickets: List<VinniTicket> = List<VinniTicket>()
}
