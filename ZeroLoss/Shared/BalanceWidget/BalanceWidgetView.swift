import SwiftUI

struct BalanceWidgetView: View {
    var body: some View {
        Label{
            Text("100")
                .font(.title.bold())
        } icon: {
            Image(systemName: "bitcoinsign.circle.fill")
                .foregroundStyle(.black)
                .font(.title.bold())
        }
        .padding()
        .background (
            RoundedRectangle(cornerRadius: 15)
                .fill(.backgroundCoins)
        )
        .padding()
    }
}

#Preview {
    BalanceWidgetView()
}
