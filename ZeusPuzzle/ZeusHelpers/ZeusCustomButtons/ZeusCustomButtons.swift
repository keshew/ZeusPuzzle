import SwiftUI

struct LevelPin: View {
    var text: String
    var geometry: GeometryProxy
    var body: some View {
        if UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) >= Int(text) ?? 0 {
            NavigationLink(destination: ZeusGameView(level: Int(text) ?? 0)) {
                ZStack {
                    Image(.openPin)
                        .resizable()
                        .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                    
                    Text(text)
                        .UnlockOutline(size: 26)
                        .offset(y: -geometry.size.width * 0.005)
                }
            }
        } else {
            ZStack {
                Image(.lockedPin)
                    .resizable()
                    .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                
                Text(text)
                    .UnlockOutline(size: 26)
                    .offset(y: -geometry.size.width * 0.005)
            }
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Float
    let range: ClosedRange<Float>
    let thumbSize: CGFloat = 40
    let trackHeight: CGFloat = 20
    let sizeSlider: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.white, Color(red: 159/255, green: 177/255, blue: 1181/255)], startPoint: .leading, endPoint: .trailing))
                    .frame(height: trackHeight)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(red: 151/255, green: 115/255, blue: 44/255), lineWidth: 3.5)
                    }
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: CGFloat(normalizedValue) * geometry.size.width, height: trackHeight)
                    .cornerRadius(6)
                
                Image(ZeusImageName.sliderPin.rawValue)
                    .resizable()
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: CGFloat(normalizedValue) * (geometry.size.width - thumbSize))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                updateValue(with: gesture.location.x, in: geometry.size.width)
                            }
                    )
            }
        }
        .frame(width: sizeSlider, height: thumbSize)
    }
    
    private var normalizedValue: Float {
        return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private func updateValue(with locationX: CGFloat, in totalWidth: CGFloat) {
        let newValue = Float((locationX / totalWidth)) * (range.upperBound - range.lowerBound) + range.lowerBound
        value = min(max(newValue, range.lowerBound), range.upperBound)
    }
}
