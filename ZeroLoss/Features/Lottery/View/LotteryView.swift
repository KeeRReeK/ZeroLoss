import SwiftUI
import RealmSwift

struct LotteryView: View {
    @State private var viewModel = LotteryViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            if viewModel.isGenerating {
                ProgressView()
            } else if let tickets = viewModel.tickets, !tickets.isEmpty {
                LotteryContentView(viewModel: viewModel, lottery: tickets)
            } else {
                LotteryEmptyView(viewModel: viewModel)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundCustomLottery)
        .task {
            viewModel.loadTickets()
        }
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    BalanceWidgetView()
                }
                .sharedBackgroundVisibility(.hidden)
            } else {
                ToolbarItem(placement: .topBarTrailing) {
                    BalanceWidgetView()
                }
            }
        }
    }
}

#Preview {
    LotteryView()
}
