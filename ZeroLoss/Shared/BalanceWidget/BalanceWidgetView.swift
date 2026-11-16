import SwiftUI

struct BalanceWidgetView: View {
    var body: some View {
        Label{
            Text("100")
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
