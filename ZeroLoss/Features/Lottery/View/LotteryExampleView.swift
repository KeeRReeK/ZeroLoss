import SwiftUI

struct LotteryExampleView: View, Equatable {

    let ticket: TicketItem
    let lotteryTitle: String
    let onOpen: () -> Void
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.ticket == rhs.ticket && lhs.lotteryTitle == rhs.lotteryTitle
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 160)
            .foregroundStyle(.black.opacity(0.1))
            .overlay {
                ticketContent()
            }
            .padding(.horizontal, 20)
    }

    private func ticketContent() -> some View {
        HStack(spacing: 0) {
            VStack {
                HStack {
                    numberLottery()
                    Spacer()
                    Text(lotteryTitle)
                        .font(.custom("FontdinerSwanky-Regular", size: 25))
                        .foregroundStyle(.backgroundVinniLottery)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(ticket.codeNumber)
                        .font(.title2.bold())
                    Spacer()
                    Image(systemName: "teddybear.fill")
                        .font(.largeTitle)
                        .foregroundStyle(ticket.bearColor)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
            Rectangle()
                .fill(.black)
                .frame(width: 4, height: 160)
            openButton()
        }
    }

    private func openButton() -> some View {
        Button {
            onOpen()
        } label: {
            buttonLabel()
                .font(.title3.bold())
                .foregroundStyle(.black)
                .padding()
                .frame(height: 160)
                .background {
                    UnevenRoundedRectangle(
                        bottomTrailingRadius: 25,
                        topTrailingRadius: 25
                    )
                    .fill(.yellow)
                }
                .contentShape(
                    UnevenRoundedRectangle(
                        bottomTrailingRadius: 25,
                        topTrailingRadius: 25
                    )
                )
        }
        .buttonStyle(.plain)
        .disabled(ticket.isOpened)
    }

    @ViewBuilder
    private func buttonLabel() -> some View {
        if ticket.isOpened {
            HStack(spacing: 2) {
                Text("+\(ticket.profit)")
                Image(systemName: "bitcoinsign.circle.fill")
            }
        } else {
            Text("open")
        }
    }

    private func numberLottery() -> some View {
        UnevenRoundedRectangle(
            topLeadingRadius: 25,
            bottomTrailingRadius: 25
        )
        .frame(width: 150, height: 50)
        .foregroundStyle(.blue.opacity(0.5))
        .overlay {
            Text("\(ticket.number)")
                .font(.title2.bold())
        }
    }
}

#Preview {
    LotteryExampleView(
        ticket: TicketItem(
            id: UUID(),
            number: 1,
            codeNumber: "VINNI-12345",
            profit: 25,
            bearColor: .orange,
            isOpened: false
        ),
        lotteryTitle: "VINNI",
        onOpen: {}
    )
}
