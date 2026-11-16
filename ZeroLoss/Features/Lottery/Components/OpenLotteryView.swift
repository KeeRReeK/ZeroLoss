
import SwiftUI

struct OpenLotteryView: View {
    var body: some View {
        HStack {
            Text("+")
                .font(.largeTitle.bold())
            Image(systemName: "bitcoinsign.circle.fill")
                .foregroundStyle(.black)
                .font(.largeTitle.bold())
            Text("10")
                .font(.largeTitle.bold())
        }
    }
}

#Preview {
    OpenLotteryView()
}
