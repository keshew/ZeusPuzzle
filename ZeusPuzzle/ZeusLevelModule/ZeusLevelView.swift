import SwiftUI

struct ZeusLevelView: View {
    @StateObject var zeusLevelModel =  ZeusLevelViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack  {
                Image(.levelBack)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.topShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.back)
                                .resizable()
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        Image(.levelLabel)
                            .resizable()
                            .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.0772)
                            .padding(.trailing, geometry.size.width * 0.2)
                        
                        Spacer()
                    }
                    .padding(.top, geometry.size.height * 0.025)
                    
                    Spacer()
                }
                
                LevelPin(text: "1",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.4, y: geometry.size.height / 1.13)
                
                LevelPin(text: "2",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.7, y: geometry.size.height / 1.2)
                
                LevelPin(text: "3",
                         geometry: geometry)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                
                LevelPin(text: "4",
                         geometry: geometry)
                    .position(x: geometry.size.width / 2.4, y: geometry.size.height / 1.43)
                
                LevelPin(text: "5",
                         geometry: geometry)
                    .position(x: geometry.size.width / 2.9, y: geometry.size.height / 1.58)
                
                LevelPin(text: "6",
                         geometry: geometry)
                    .position(x: geometry.size.width / 2.1, y: geometry.size.height / 1.68)
                
                LevelPin(text: "7",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.65, y: geometry.size.height / 1.78)
                
                LevelPin(text: "8",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.3, y: geometry.size.height / 1.83)
                
                LevelPin(text: "9",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.1, y: geometry.size.height / 1.95)
                
                LevelPin(text: "10",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.3, y: geometry.size.height / 2.2)
                
                LevelPin(text: "11",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.6, y: geometry.size.height / 2.6)
                
                LevelPin(text: "12",
                         geometry: geometry)
                    .position(x: geometry.size.width / 1.4, y: geometry.size.height / 3.2)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusLevelView()
}

