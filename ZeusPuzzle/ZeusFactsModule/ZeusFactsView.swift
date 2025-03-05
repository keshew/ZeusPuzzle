import SwiftUI

struct ZeusFactsView: View {
    @StateObject var zeusFactsModel = ZeusFactsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.settingsBack)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.topShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
                
                Image(.zeusShop)
                    .resizable()
                    .frame(width: geometry.size.width + 50, height: geometry.size.height * 0.8)
                    .position(x: geometry.size.width / 1.9, y: geometry.size.height / 1.5)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                if UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) == 1 {
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
                        }
                        
                        Spacer()
                        
                        Text("COMPLETE LEVEL TO UNLOCK FACT")
                            .UnlockOutline(size: 35)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                } else {
                    ScrollView(showsIndicators: false) {
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
                                
                                ZStack {
                                    Image(.roundedSilver)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                                      
                                    Text("FACT#\(zeusFactsModel.currentIndex + 1)")
                                        .UnlockOutline(size: 20)
                                }
                                .padding(.trailing, geometry.size.width * 0.2)
                                
                                Spacer()
                            }
                            .padding(.top, geometry.size.height * 0.025)
                            
                            Spacer(minLength: geometry.size.height * 0.18)
                            
                            HStack {
                                Spacer()
                                
                                ZStack {
                                    Image(.shopBack)
                                        .resizable()
                                        .frame(width: geometry.size.width - geometry.size.width * 0.25, height: geometry.size.height * 0.5)
                                      
                                    Text(zeusFactsModel.contact.facts[zeusFactsModel.currentIndex])
                                        .UnlockOutline(size: 22)
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width - geometry.size.width * 0.425, height: geometry.size.height * 0.48)
                                }
                                .padding(.trailing)
                            }
                            
                            Spacer(minLength: geometry.size.height * 0.11)
                            Text("SWIPE LEFT\\RIGHT to NEXT\\PREV PAGE")
                                .UnlockOutline(size: 25)
                        }
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged({ value in
                        zeusFactsModel.dragOffset = value.translation.width
                        zeusFactsModel.isDragging = true
                    })
                    .onEnded({ value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if zeusFactsModel.currentIndex > 0 {
                                    zeusFactsModel.currentIndex -= 1
                                }
                            } else {
                                if zeusFactsModel.currentIndex < UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) - 2 {
                                    zeusFactsModel.currentIndex += 1
                                }
                            }
                        }
                        zeusFactsModel.dragOffset = 0
                        zeusFactsModel.isDragging = false
                    })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusFactsView()
}
