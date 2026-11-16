import SwiftUI

struct LotteryView: View {
    var body: some View {
        VStack {
            Spacer()
            LotteryEmptyView()
            LotteryContentView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundCustomLottery)
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
