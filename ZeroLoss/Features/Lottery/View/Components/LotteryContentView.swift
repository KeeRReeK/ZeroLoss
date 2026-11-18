import SwiftUI

struct LotteryContentView: View {
    
    let viewModel: LotteryViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items) { ticket in
                LotteryExampleView(
                    ticket: ticket,
                    lotteryTitle: viewModel.lotteryTitle,
                    onOpen: {
                        viewModel.openTicket(id: ticket.id)
                    }
                )
                .equatable()
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onAppear {
                    viewModel.ticketAppeared(ticket)
                }
            }
            
            if viewModel.hasMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onAppear {
                        viewModel.loadMoreIfNeeded()
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .contentMargins(.vertical, 8, for: .scrollContent)
    }
}
