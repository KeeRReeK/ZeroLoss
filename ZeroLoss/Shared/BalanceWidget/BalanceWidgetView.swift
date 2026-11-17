import SwiftUI

struct BalanceWidgetView: View {
    @AppStorage(StorageKeys.balance) private var balance: Int = BalanceStorage.initial
    
    var body: some View {
        Label{
            Text(balance.shortFormatted)
        } icon: {
            Image(systemName: "bitcoinsign.circle.fill")
                .foregroundStyle(.black)
        }
        .font(.largeTitle.bold())
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background (
            RoundedRectangle(cornerRadius: 15)
                .fill(.backgroundCoins)
        )
        .labelStyle(.titleAndIcon)
    }
}

#Preview {
    BalanceWidgetView()
}
