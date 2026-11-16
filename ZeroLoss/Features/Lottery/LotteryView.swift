import SwiftUI

struct LotteryView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                BalanceWidgetView()
            }
            Spacer()
            LotteryEmptyView()
            LotteryContentView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundCustomLottery)
    }
}

#Preview {
    LotteryView()
}
