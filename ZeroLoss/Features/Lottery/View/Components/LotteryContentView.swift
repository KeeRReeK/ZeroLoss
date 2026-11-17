import SwiftUI
import RealmSwift

struct LotteryContentView: View {
    
    let viewModel: LotteryViewModel
    let lottery: Results<VinniTicket>
    
    var body: some View {
        List {
            ForEach(lottery) { ticket in
                LotteryExampleView(viewModel: viewModel, ticket: ticket)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .contentMargins(.vertical, 8, for: .scrollContent)
    }
}

//#Preview {
//    LotteryContentView(viewModel: LotteryViewModel(), lottery: Result<VinniTicket>)
//}
