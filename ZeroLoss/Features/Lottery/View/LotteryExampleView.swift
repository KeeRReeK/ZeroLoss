import SwiftUI
import Realm

struct LotteryExampleView: View {
    
    let viewModel: LotteryViewModel
    let ticket: VinniTicket
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 160)
            .foregroundStyle(.black.opacity(0.1))
            .overlay {
                if ticket.isWinning {
                    OpenLotteryView()
                } else {
                    ClosedLotteryView(viewModel: viewModel, ticket: ticket)
                }
            }
            .padding(.horizontal, 20)
    }
}

#Preview {
    LotteryExampleView(viewModel: LotteryViewModel(), ticket: VinniTicket())
}
