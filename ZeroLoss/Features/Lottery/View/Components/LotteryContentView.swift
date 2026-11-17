import SwiftUI
import RealmSwift

struct LotteryContentView: View {
    
    let viewModel: LotteryViewModel
    let lottery: Results<VinniTicket>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(lottery) { ticket in
                    LotteryExampleView(viewModel: viewModel, ticket: ticket)
                }
            }
            .padding(.vertical)
        }
    }
}

//#Preview {
//    LotteryContentView(viewModel: LotteryViewModel(), lottery: Result<VinniTicket>)
//}
