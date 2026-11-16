import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                BalanceWidgetView()
            }
            Spacer()
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 100)
                    .foregroundStyle(.backgroundVinniLottery)
                    .padding(.horizontal, 50)
                    .overlay {
                        Text("VINNI")
                            .font(.custom("FontdinerSwanky-Regular", size: 35))
                            .foregroundStyle(.white)
                    }
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
            .foregroundStyle(.backgroundCustomLottery)
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
