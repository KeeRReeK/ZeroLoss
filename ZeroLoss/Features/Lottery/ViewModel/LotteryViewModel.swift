import Foundation

@Observable
@MainActor
final class LotteryViewModel {
    enum State: Equatable {
        case loading
        case empty
        case generating
        case loaded
        case failed(String)
    }
    
    private(set) var state: State = .loading
    
    private(set) var items: [TicketItem] = []
    private(set) var lotteryTitle: String = "VINNI"
    private(set) var totalCount: Int = 0
    
    var hasMore: Bool {
        items.count < totalCount
    }
    
    private let pageSize = 300
    private let prefetchDistance = 50
    
    private var isLoadingPage = false
    private let repository = LotteryRepository()
    
    func reload() async {
        state = .loading
        items = []
        totalCount = 0
        
        await loadNextPage()
        
        if case .failed = state {
            return
        }
        state = items.isEmpty ? .empty : .loaded
    }
    
    func ticketAppeared(_ ticket: TicketItem) {
        guard hasMore, !isLoadingPage else {
            return
        }
        guard items.suffix(prefetchDistance).contains(where: { $0.id == ticket.id }) else {
            return
        }
        Task { await loadNextPage() }
    }
    
    func loadMoreIfNeeded() {
        guard hasMore, !isLoadingPage else {
            return
        }
        Task { await loadNextPage() }
    }

    
    private func loadNextPage() async {
        guard !isLoadingPage else {
            return
        }
        
        guard items.isEmpty || hasMore else {
            return
        }
        
        isLoadingPage = true
        defer {
            isLoadingPage = false
        }
        
        let offset = items.count
        let limit = pageSize
        let repository = repository
        
        do {
            let page = try await Task.detached(priority: .userInitiated) {
                try await repository.fetchPage(offset: offset, limit: limit)
            }.value
            
            totalCount = page.totalCount
            lotteryTitle = page.lotteryTitle
            items.append(contentsOf: page.items)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    func generateTickets() async {
        guard state == .empty else {
            return
        }
        
        state = .generating
        let repository = repository
        
        do {
            try await Task.detached(priority: .userInitiated) {
                try await repository.generateTickets()
            }.value
            
            await reload()
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    func openTicket(id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id}),
              !items[index].isOpened else {
            return
        }
        
        let profit = items[index].profit
        
        items[index].isOpened = true
        BalanceStorage.add(profit)
        
        let repository = repository
        Task {
            do {
                try await Task.detached(priority: .userInitiated) {
                    try await repository.openTicket(id: id)
                }.value
            } catch {
                if let index = items.firstIndex(where: {$0.id == id}) {
                    items[index].isOpened = false
                }
                BalanceStorage.add(-profit)
                state = .failed(error.localizedDescription)
            }
        }
    }
    
    
}
