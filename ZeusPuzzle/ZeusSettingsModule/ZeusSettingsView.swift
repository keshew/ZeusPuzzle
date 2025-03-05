import SwiftUI

struct ZeusSettingsView: View {
    @StateObject var zeusSettingsModel = ZeusSettingsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var audioManager = AudioManager.shared
    
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
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
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
                            
                            Image(.settingsLabel)
                                .resizable()
                                .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.0772)
                                .padding(.trailing, geometry.size.width * 0.2)
                            
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.025)
                        
                        Spacer(minLength: geometry.size.height * 0.09)
                        
                        VStack(spacing: geometry.size.height * 0.025) {
                            HStack {
                                VStack {
                                    Image(.sound)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.25)
                                    
                                    Text("SOUND")
                                        .UnlockOutline(size: 30)
                                }
                                .padding(.leading, geometry.size.width * 0.075)
                                
                                Spacer()
                                
                                CustomSlider(value: $audioManager.soundEffectVolume,
                                             range: 0...10,
                                             sizeSlider: geometry.size.width * 0.52)
                                .padding(.trailing, geometry.size.width * 0.075)
                                .offset(y: -geometry.size.height * 0.00625)
                            }
                            
                            HStack {
                                VStack {
                                    Image(.music)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.25)
                                    
                                    Text("MUSIC")
                                        .UnlockOutline(size: 30)
                                }
                                .padding(.leading, geometry.size.width * 0.075)
                                
                                Spacer()
                                
                                CustomSlider(value: $audioManager.backgroundVolume,
                                             range: 0...10,
                                             sizeSlider: geometry.size.width * 0.52)
                                .padding(.trailing, geometry.size.width * 0.075)
                                .offset(y: -geometry.size.height * 0.00625)
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.1)
                        
                        Button(action: {
                            UserDefaultsManager().refreshProgress()
                        }) {
                            Image(.refreshProgress)
                                .resizable()
                                .frame(width: geometry.size.width - geometry.size.width * 0.25,
                                       
                                       height: geometry.size.height * 0.14)
                        }
                    }
                }
            }
            .onAppear {
                let (backgroundVolume, soundEffectVolume) = UserDefaultsManager().loadVolumeSettings()
                audioManager.backgroundVolume = backgroundVolume
                audioManager.soundEffectVolume = soundEffectVolume
            }
            
            .onDisappear() {
                UserDefaultsManager().saveVolumeSettings(backgroundVolume: audioManager.backgroundVolume,
                                                         soundEffectVolume: audioManager.soundEffectVolume)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusSettingsView()
}
