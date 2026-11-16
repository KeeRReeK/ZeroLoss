import SwiftUI

struct LotteryEmptyView: View {
    var body: some View {
        Button{
            
        } label: {
            Text("Buy 100k bilets")
                .font(.custom("FontdinerSwanky-Regular", size: 35))
        }
        .foregroundStyle(.yellow)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
        }
        .padding()
    }
}

#Preview {
    LotteryEmptyView()
}
