import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                BalanceWidgetView()
            }
            Spacer()
            
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 100)
                .foregroundStyle(.backgroundLottery)
                .padding(.horizontal, 50)
                .overlay {
                    Text("VINNI")
                        .font(.title.bold())
                }
            lotteryExample()
            lotteryExample()
            lotteryExample()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundHome)
    }
    
    private func lotteryExample() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 100)
            .foregroundStyle(.backgroundLottery)
            .padding(.horizontal, 50)
            .overlay {
                Text("Comming soon...")
                    .font(.title.bold())
            }
    }
}

#Preview {
    HomeView()
}
