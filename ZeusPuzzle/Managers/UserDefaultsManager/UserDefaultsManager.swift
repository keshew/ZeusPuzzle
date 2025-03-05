import SwiftUI

enum Keys: String {
    case currentLevel = "currentLevel"
    case money = "money"
    case backgroundVolume = "backgroundVolume"
    case soundEffectVolume = "soundEffectVolume"
    case timeCount = "timeCount"
    case clueCount = "hummerCount"
}

class UserDefaultsManager: ObservableObject {
    static let defaults = UserDefaults.standard
    
    func firstLaunch() {
        if UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) == nil {
            UserDefaultsManager.defaults.set(1, forKey: Keys.currentLevel.rawValue)
            UserDefaultsManager.defaults.set(2, forKey: Keys.timeCount.rawValue)
            UserDefaultsManager.defaults.set(2, forKey: Keys.clueCount.rawValue)
            UserDefaultsManager.defaults.set(100, forKey: Keys.money.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.backgroundVolume.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.soundEffectVolume.rawValue)
        }
    }
    
    func refreshProgress() {
        UserDefaultsManager.defaults.set(1, forKey: Keys.currentLevel.rawValue)
        UserDefaultsManager.defaults.set(2, forKey: Keys.timeCount.rawValue)
        UserDefaultsManager.defaults.set(2, forKey: Keys.clueCount.rawValue)
        UserDefaultsManager.defaults.set(100, forKey: Keys.money.rawValue)
        UserDefaultsManager.defaults.set(0.5, forKey: Keys.backgroundVolume.rawValue)
        UserDefaultsManager.defaults.set(0.5, forKey: Keys.soundEffectVolume.rawValue)
    }
    
    func useBonus(key: String) {
        let hummer = UserDefaultsManager.defaults.integer(forKey: key)
        if hummer >= 1 {
            UserDefaultsManager.defaults.set(hummer - 1, forKey: key)
        }
    }
    
    func buyBonus(key: String) {
        let money = UserDefaultsManager.defaults.integer(forKey: Keys.money.rawValue)
        let bonus = UserDefaultsManager.defaults.integer(forKey: key)
        if money >= 30 {
            UserDefaultsManager.defaults.set(bonus + 1, forKey: key)
            UserDefaultsManager.defaults.set(money - 30, forKey: Keys.money.rawValue)
        }
    }
    
    func completeLevel() {
        let money = UserDefaultsManager.defaults.integer(forKey: Keys.money.rawValue)
        let currentLevel = UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue)
        
        if currentLevel <= 12 {
            UserDefaultsManager.defaults.set(currentLevel + 1, forKey: Keys.currentLevel.rawValue)
            UserDefaultsManager.defaults.set(money + 30, forKey: Keys.money.rawValue)
        }
    }
    
    func saveVolumeSettings(backgroundVolume: Float, soundEffectVolume: Float) {
        UserDefaultsManager.defaults.set(backgroundVolume, forKey: Keys.backgroundVolume.rawValue)
        UserDefaultsManager.defaults.set(soundEffectVolume, forKey: Keys.soundEffectVolume.rawValue)
    }
    
    func loadVolumeSettings() -> (Float, Float) {
        var backgroundVolume = UserDefaultsManager.defaults.float(forKey: Keys.backgroundVolume.rawValue)
        var soundEffectVolume = UserDefaultsManager.defaults.float(forKey: Keys.soundEffectVolume.rawValue)
        if backgroundVolume == 0.0 && soundEffectVolume == 0.0 {
            backgroundVolume = 0.5
            soundEffectVolume = 0.5
        }
        return (backgroundVolume, soundEffectVolume)
    }
}

