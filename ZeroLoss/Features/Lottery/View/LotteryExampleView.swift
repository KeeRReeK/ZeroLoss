
import SwiftUI

struct LotteryExampleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 160)
            .foregroundStyle(.black.opacity(0.1))
            .overlay {
                ClosedLotteryView()
//                OpenLotteryView()
            }
            .padding(.horizontal, 20)
    }
    
    
}

#Preview {
    LotteryExampleView()
}
