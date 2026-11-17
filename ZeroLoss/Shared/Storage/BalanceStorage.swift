import Foundation

enum BalanceStorage {
    static let initial = 100

    static var balance: Int {
        get { UserDefaults.standard.object(forKey: StorageKeys.balance) as? Int ?? initial }
        set { UserDefaults.standard.set(newValue, forKey: StorageKeys.balance) }
    }

    static func add(_ amount: Int) {
        balance += amount
    }
}
