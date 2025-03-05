import SwiftUI

extension Text {
    func UnlockOutline(size: CGFloat,
                       color: Color = .white,
                       outlineWidth: CGFloat = 0.5,
                       colorOutline: Color = Color(red: 122/255, green: 92/255, blue: 8/255)) -> some View {
        self.font(.custom("Unlock-Regular", size: size))
            .foregroundColor(color)
            .outlineText(color: colorOutline, width: outlineWidth)
    }
    
    func Unlock(size: CGFloat,
                color: Color = .white) -> some View {
        self.font(.custom("Unlock-Regular", size: size))
            .foregroundColor(color)
    }
}
