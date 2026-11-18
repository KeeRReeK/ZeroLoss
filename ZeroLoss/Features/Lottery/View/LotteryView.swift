import SwiftUI

struct LotteryView: View {
    @State private var viewModel = LotteryViewModel()
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundCustomLottery)
            .task {
                await viewModel.reload()
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
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .empty:
            LotteryEmptyView(viewModel: viewModel)
        case .generating:
            ProgressView("Generating 100 000 tickets")
        case .loaded:
            LotteryContentView(viewModel: viewModel)
        case .failed(let message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    LotteryView()
}
