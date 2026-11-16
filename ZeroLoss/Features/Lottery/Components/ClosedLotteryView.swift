
import SwiftUI

struct ClosedLotteryView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                HStack {
                    numberLottery()
                    Spacer()
                    Text("VINNI")
                        .font(.custom("FontdinerSwanky-Regular", size: 25))
                        .foregroundStyle(.backgroundVinniLottery)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("z25j8577a3d")
                        .font(.title2.bold())
                    Spacer()
                    Image(systemName: "teddybear.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
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
            
        } label: {
            Text("open")
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
    }
    
    private func numberLottery() -> some View {
        UnevenRoundedRectangle(
            topLeadingRadius: 25,
            bottomTrailingRadius: 25
        )
        .frame(width: 150, height: 50)
        .foregroundStyle(.blue.opacity(0.5))
        .overlay {
            Text("100 000")
                .font(.title2.bold())
        }
    }
}

#Preview {
    ClosedLotteryView()
}
