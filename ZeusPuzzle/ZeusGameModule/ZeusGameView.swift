import SwiftUI
import SpriteKit

class ZeusGameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isRules = false
    @Published var timeLeft = 120
    @Published var score = 0
    @Published var scene = SKScene()
    @Published var ud = UserDefaultsManager()
}

class ZeusGameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: ZeusGameData?
    let level: Int
    var puzzleSize: CGFloat = 60
    var puzzles: [[SKSpriteNode]] = []
    var selectedPuzzle: SKSpriteNode?
    var correctPuzzleArrangement: [String] = []
    var timer: Timer?
    var timeLabel: SKLabelNode!
    var scoreCountLabel: SKLabelNode!
    var bonusClueCount: SKLabelNode!
    var bonusTimeCount: SKLabelNode!
    var gridSize = 4
    
    init(level: Int) {
        self.level = level
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func returnAllPuzzles() -> [String] {
        switch level {
        case 1:
            return [ZeusImageName.level1p1.rawValue,
                    ZeusImageName.level1p2.rawValue,
                    ZeusImageName.level1p3.rawValue,
                    ZeusImageName.level1p4.rawValue,
                    ZeusImageName.level1p5.rawValue,
                    ZeusImageName.level1p6.rawValue,
                    ZeusImageName.level1p7.rawValue,
                    ZeusImageName.level1p8.rawValue,
                    ZeusImageName.level1p9.rawValue,
                    ZeusImageName.level1p10.rawValue,
                    ZeusImageName.level1p11.rawValue,
                    ZeusImageName.level1p12.rawValue,
                    ZeusImageName.level1p13.rawValue,
                    ZeusImageName.level1p14.rawValue,
                    ZeusImageName.level1p15.rawValue,
                    ZeusImageName.level1p16.rawValue].shuffled()
            
        case 2:
            return [ZeusImageName.level2p1.rawValue,
                    ZeusImageName.level2p2.rawValue,
                    ZeusImageName.level2p3.rawValue,
                    ZeusImageName.level2p4.rawValue,
                    ZeusImageName.level2p5.rawValue,
                    ZeusImageName.level2p6.rawValue,
                    ZeusImageName.level2p7.rawValue,
                    ZeusImageName.level2p8.rawValue,
                    ZeusImageName.level2p9.rawValue,
                    ZeusImageName.level2p10.rawValue,
                    ZeusImageName.level2p11.rawValue,
                    ZeusImageName.level2p12.rawValue,
                    ZeusImageName.level2p13.rawValue,
                    ZeusImageName.level2p14.rawValue,
                    ZeusImageName.level2p15.rawValue,
                    ZeusImageName.level2p16.rawValue].shuffled()
            
        case 3:
            return [ZeusImageName.level3p1.rawValue,
                    ZeusImageName.level3p2.rawValue,
                    ZeusImageName.level3p3.rawValue,
                    ZeusImageName.level3p4.rawValue,
                    ZeusImageName.level3p5.rawValue,
                    ZeusImageName.level3p6.rawValue,
                    ZeusImageName.level3p7.rawValue,
                    ZeusImageName.level3p8.rawValue,
                    ZeusImageName.level3p9.rawValue,
                    ZeusImageName.level3p10.rawValue,
                    ZeusImageName.level3p11.rawValue,
                    ZeusImageName.level3p12.rawValue,
                    ZeusImageName.level3p13.rawValue,
                    ZeusImageName.level3p14.rawValue,
                    ZeusImageName.level3p15.rawValue,
                    ZeusImageName.level3p16.rawValue].shuffled()
            
        case 4:
            return [ZeusImageName.level4p1.rawValue,
                    ZeusImageName.level4p2.rawValue,
                    ZeusImageName.level4p3.rawValue,
                    ZeusImageName.level4p4.rawValue,
                    ZeusImageName.level4p5.rawValue,
                    ZeusImageName.level4p6.rawValue,
                    ZeusImageName.level4p7.rawValue,
                    ZeusImageName.level4p8.rawValue,
                    ZeusImageName.level4p9.rawValue,
                    ZeusImageName.level4p10.rawValue,
                    ZeusImageName.level4p11.rawValue,
                    ZeusImageName.level4p12.rawValue,
                    ZeusImageName.level4p13.rawValue,
                    ZeusImageName.level4p14.rawValue,
                    ZeusImageName.level4p15.rawValue,
                    ZeusImageName.level4p16.rawValue].shuffled()
            
        case 5:
            return [ZeusImageName.level5p1.rawValue,
                    ZeusImageName.level5p2.rawValue,
                    ZeusImageName.level5p3.rawValue,
                    ZeusImageName.level5p4.rawValue,
                    ZeusImageName.level5p5.rawValue,
                    ZeusImageName.level5p6.rawValue,
                    ZeusImageName.level5p7.rawValue,
                    ZeusImageName.level5p8.rawValue,
                    ZeusImageName.level5p9.rawValue,
                    ZeusImageName.level5p10.rawValue,
                    ZeusImageName.level5p11.rawValue,
                    ZeusImageName.level5p12.rawValue,
                    ZeusImageName.level5p13.rawValue,
                    ZeusImageName.level5p14.rawValue,
                    ZeusImageName.level5p15.rawValue,
                    ZeusImageName.level5p16.rawValue,
                    ZeusImageName.level5p17.rawValue,
                    ZeusImageName.level5p18.rawValue,
                    ZeusImageName.level5p19.rawValue,
                    ZeusImageName.level5p20.rawValue,
                    ZeusImageName.level5p21.rawValue,
                    ZeusImageName.level5p22.rawValue,
                    ZeusImageName.level5p23.rawValue,
                    ZeusImageName.level5p24.rawValue,
                    ZeusImageName.level5p25.rawValue,
                    ZeusImageName.level5p26.rawValue,
                    ZeusImageName.level5p27.rawValue,
                    ZeusImageName.level5p28.rawValue,
                    ZeusImageName.level5p29.rawValue,
                    ZeusImageName.level5p30.rawValue,
                    ZeusImageName.level5p31.rawValue,
                    ZeusImageName.level5p32.rawValue,
                    ZeusImageName.level5p33.rawValue,
                    ZeusImageName.level5p34.rawValue,
                    ZeusImageName.level5p35.rawValue,
                    ZeusImageName.level5p36.rawValue].shuffled()
            
        case 6:
            return [ZeusImageName.level6p1.rawValue,
                    ZeusImageName.level6p2.rawValue,
                    ZeusImageName.level6p3.rawValue,
                    ZeusImageName.level6p4.rawValue,
                    ZeusImageName.level6p5.rawValue,
                    ZeusImageName.level6p6.rawValue,
                    ZeusImageName.level6p7.rawValue,
                    ZeusImageName.level6p8.rawValue,
                    ZeusImageName.level6p9.rawValue,
                    ZeusImageName.level6p10.rawValue,
                    ZeusImageName.level6p11.rawValue,
                    ZeusImageName.level6p12.rawValue,
                    ZeusImageName.level6p13.rawValue,
                    ZeusImageName.level6p14.rawValue,
                    ZeusImageName.level6p15.rawValue,
                    ZeusImageName.level6p16.rawValue,
                    ZeusImageName.level6p17.rawValue,
                    ZeusImageName.level6p18.rawValue,
                    ZeusImageName.level6p19.rawValue,
                    ZeusImageName.level6p20.rawValue,
                    ZeusImageName.level6p21.rawValue,
                    ZeusImageName.level6p22.rawValue,
                    ZeusImageName.level6p23.rawValue,
                    ZeusImageName.level6p24.rawValue,
                    ZeusImageName.level6p25.rawValue,
                    ZeusImageName.level6p26.rawValue,
                    ZeusImageName.level6p27.rawValue,
                    ZeusImageName.level6p28.rawValue,
                    ZeusImageName.level6p29.rawValue,
                    ZeusImageName.level6p30.rawValue,
                    ZeusImageName.level6p31.rawValue,
                    ZeusImageName.level6p32.rawValue,
                    ZeusImageName.level6p33.rawValue,
                    ZeusImageName.level6p34.rawValue,
                    ZeusImageName.level6p35.rawValue,
                    ZeusImageName.level6p36.rawValue].shuffled()
            
        case 7:
            return [ZeusImageName.level7p1.rawValue,
                    ZeusImageName.level7p2.rawValue,
                    ZeusImageName.level7p3.rawValue,
                    ZeusImageName.level7p4.rawValue,
                    ZeusImageName.level7p5.rawValue,
                    ZeusImageName.level7p6.rawValue,
                    ZeusImageName.level7p7.rawValue,
                    ZeusImageName.level7p8.rawValue,
                    ZeusImageName.level7p9.rawValue,
                    ZeusImageName.level7p10.rawValue,
                    ZeusImageName.level7p11.rawValue,
                    ZeusImageName.level7p12.rawValue,
                    ZeusImageName.level7p13.rawValue,
                    ZeusImageName.level7p14.rawValue,
                    ZeusImageName.level7p15.rawValue,
                    ZeusImageName.level7p16.rawValue,
                    ZeusImageName.level7p17.rawValue,
                    ZeusImageName.level7p18.rawValue,
                    ZeusImageName.level7p19.rawValue,
                    ZeusImageName.level7p20.rawValue,
                    ZeusImageName.level7p21.rawValue,
                    ZeusImageName.level7p22.rawValue,
                    ZeusImageName.level7p23.rawValue,
                    ZeusImageName.level7p24.rawValue,
                    ZeusImageName.level7p25.rawValue,
                    ZeusImageName.level7p26.rawValue,
                    ZeusImageName.level7p27.rawValue,
                    ZeusImageName.level7p28.rawValue,
                    ZeusImageName.level7p29.rawValue,
                    ZeusImageName.level7p30.rawValue,
                    ZeusImageName.level7p31.rawValue,
                    ZeusImageName.level7p32.rawValue,
                    ZeusImageName.level7p33.rawValue,
                    ZeusImageName.level7p34.rawValue,
                    ZeusImageName.level7p35.rawValue,
                    ZeusImageName.level7p36.rawValue].shuffled()
            
        case 8:
            return [ZeusImageName.level8p1.rawValue,
                    ZeusImageName.level8p2.rawValue,
                    ZeusImageName.level8p3.rawValue,
                    ZeusImageName.level8p4.rawValue,
                    ZeusImageName.level8p5.rawValue,
                    ZeusImageName.level8p6.rawValue,
                    ZeusImageName.level8p7.rawValue,
                    ZeusImageName.level8p8.rawValue,
                    ZeusImageName.level8p9.rawValue,
                    ZeusImageName.level8p10.rawValue,
                    ZeusImageName.level8p11.rawValue,
                    ZeusImageName.level8p12.rawValue,
                    ZeusImageName.level8p13.rawValue,
                    ZeusImageName.level8p14.rawValue,
                    ZeusImageName.level8p15.rawValue,
                    ZeusImageName.level8p16.rawValue,
                    ZeusImageName.level8p17.rawValue,
                    ZeusImageName.level8p18.rawValue,
                    ZeusImageName.level8p19.rawValue,
                    ZeusImageName.level8p20.rawValue,
                    ZeusImageName.level8p21.rawValue,
                    ZeusImageName.level8p22.rawValue,
                    ZeusImageName.level8p23.rawValue,
                    ZeusImageName.level8p24.rawValue,
                    ZeusImageName.level8p25.rawValue,
                    ZeusImageName.level8p26.rawValue,
                    ZeusImageName.level8p27.rawValue,
                    ZeusImageName.level8p28.rawValue,
                    ZeusImageName.level8p29.rawValue,
                    ZeusImageName.level8p30.rawValue,
                    ZeusImageName.level8p31.rawValue,
                    ZeusImageName.level8p32.rawValue,
                    ZeusImageName.level8p33.rawValue,
                    ZeusImageName.level8p34.rawValue,
                    ZeusImageName.level8p35.rawValue,
                    ZeusImageName.level8p36.rawValue].shuffled()
        case 9:
            return [
                   ZeusImageName.level9p57.rawValue,
                   ZeusImageName.level9p58.rawValue,
                   ZeusImageName.level9p59.rawValue,
                   ZeusImageName.level9p60.rawValue,
                   ZeusImageName.level9p61.rawValue,
                   ZeusImageName.level9p62.rawValue,
                   ZeusImageName.level9p63.rawValue,
                   ZeusImageName.level9p64.rawValue,
                   
                   ZeusImageName.level9p49.rawValue,
                   ZeusImageName.level9p50.rawValue,
                   ZeusImageName.level9p51.rawValue,
                   ZeusImageName.level9p52.rawValue,
                   ZeusImageName.level9p53.rawValue,
                   ZeusImageName.level9p54.rawValue,
                   ZeusImageName.level9p55.rawValue,
                   ZeusImageName.level9p56.rawValue,
                   
                   ZeusImageName.level9p41.rawValue,
                   ZeusImageName.level9p42.rawValue,
                   ZeusImageName.level9p43.rawValue,
                   ZeusImageName.level9p44.rawValue,
                   ZeusImageName.level9p45.rawValue,
                   ZeusImageName.level9p46.rawValue,
                   ZeusImageName.level9p47.rawValue,
                   ZeusImageName.level9p48.rawValue,
                   
                   ZeusImageName.level9p33.rawValue,
                   ZeusImageName.level9p34.rawValue,
                   ZeusImageName.level9p35.rawValue,
                   ZeusImageName.level9p36.rawValue,
                   ZeusImageName.level9p37.rawValue,
                   ZeusImageName.level9p38.rawValue,
                   ZeusImageName.level9p39.rawValue,
                   ZeusImageName.level9p40.rawValue,
                   
                   ZeusImageName.level9p25.rawValue,
                   ZeusImageName.level9p26.rawValue,
                   ZeusImageName.level9p27.rawValue,
                   ZeusImageName.level9p28.rawValue,
                   ZeusImageName.level9p29.rawValue,
                   ZeusImageName.level9p30.rawValue,
                   ZeusImageName.level9p31.rawValue,
                   ZeusImageName.level9p32.rawValue,
                   
                   ZeusImageName.level9p17.rawValue,
                   ZeusImageName.level9p18.rawValue,
                   ZeusImageName.level9p19.rawValue,
                   ZeusImageName.level9p20.rawValue,
                   ZeusImageName.level9p21.rawValue,
                   ZeusImageName.level9p22.rawValue,
                   ZeusImageName.level9p23.rawValue,
                   ZeusImageName.level9p24.rawValue,
                   
                   ZeusImageName.level9p9.rawValue,
                   ZeusImageName.level9p10.rawValue,
                   ZeusImageName.level9p11.rawValue,
                   ZeusImageName.level9p12.rawValue,
                   ZeusImageName.level9p13.rawValue,
                   ZeusImageName.level9p14.rawValue,
                   ZeusImageName.level9p15.rawValue,
                   ZeusImageName.level9p16.rawValue,
                   
                   ZeusImageName.level9p1.rawValue,
                   ZeusImageName.level9p2.rawValue,
                   ZeusImageName.level9p3.rawValue,
                   ZeusImageName.level9p4.rawValue,
                   ZeusImageName.level9p5.rawValue,
                   ZeusImageName.level9p6.rawValue,
                   ZeusImageName.level9p7.rawValue,
                   ZeusImageName.level9p8.rawValue].shuffled()
            
        case 10:
            return [
                   ZeusImageName.level10p57.rawValue,
                   ZeusImageName.level10p58.rawValue,
                   ZeusImageName.level10p59.rawValue,
                   ZeusImageName.level10p60.rawValue,
                   ZeusImageName.level10p61.rawValue,
                   ZeusImageName.level10p62.rawValue,
                   ZeusImageName.level10p63.rawValue,
                   ZeusImageName.level10p64.rawValue,
                   ZeusImageName.level10p49.rawValue,
                   ZeusImageName.level10p50.rawValue,
                   ZeusImageName.level10p51.rawValue,
                   ZeusImageName.level10p52.rawValue,
                   ZeusImageName.level10p53.rawValue,
                   ZeusImageName.level10p54.rawValue,
                   ZeusImageName.level10p55.rawValue,
                   ZeusImageName.level10p56.rawValue,
                   ZeusImageName.level10p41.rawValue,
                   ZeusImageName.level10p42.rawValue,
                   ZeusImageName.level10p43.rawValue,
                   ZeusImageName.level10p44.rawValue,
                   ZeusImageName.level10p45.rawValue,
                   ZeusImageName.level10p46.rawValue,
                   ZeusImageName.level10p47.rawValue,
                   ZeusImageName.level10p48.rawValue,
                   ZeusImageName.level10p33.rawValue,
                   ZeusImageName.level10p34.rawValue,
                   ZeusImageName.level10p35.rawValue,
                   ZeusImageName.level10p36.rawValue,
                   ZeusImageName.level10p37.rawValue,
                   ZeusImageName.level10p38.rawValue,
                   ZeusImageName.level10p39.rawValue,
                   ZeusImageName.level10p40.rawValue,
                   ZeusImageName.level10p25.rawValue,
                   ZeusImageName.level10p26.rawValue,
                   ZeusImageName.level10p27.rawValue,
                   ZeusImageName.level10p28.rawValue,
                   ZeusImageName.level10p29.rawValue,
                   ZeusImageName.level10p30.rawValue,
                   ZeusImageName.level10p31.rawValue,
                   ZeusImageName.level10p32.rawValue,
                   ZeusImageName.level10p17.rawValue,
                   ZeusImageName.level10p18.rawValue,
                   ZeusImageName.level10p19.rawValue,
                   ZeusImageName.level10p20.rawValue,
                   ZeusImageName.level10p21.rawValue,
                   ZeusImageName.level10p22.rawValue,
                   ZeusImageName.level10p23.rawValue,
                   ZeusImageName.level10p24.rawValue,
                   ZeusImageName.level10p9.rawValue,
                   ZeusImageName.level10p10.rawValue,
                   ZeusImageName.level10p11.rawValue,
                   ZeusImageName.level10p12.rawValue,
                   ZeusImageName.level10p13.rawValue,
                   ZeusImageName.level10p14.rawValue,
                   ZeusImageName.level10p15.rawValue,
                   ZeusImageName.level10p16.rawValue,
                   ZeusImageName.level10p1.rawValue,
                   ZeusImageName.level10p2.rawValue,
                   ZeusImageName.level10p3.rawValue,
                   ZeusImageName.level10p4.rawValue,
                   ZeusImageName.level10p5.rawValue,
                   ZeusImageName.level10p6.rawValue,
                   ZeusImageName.level10p7.rawValue,
                   ZeusImageName.level10p8.rawValue
               ].shuffled()
            
        case 11:
            return [
                   ZeusImageName.level11p57.rawValue,
                   ZeusImageName.level11p58.rawValue,
                   ZeusImageName.level11p59.rawValue,
                   ZeusImageName.level11p60.rawValue,
                   ZeusImageName.level11p61.rawValue,
                   ZeusImageName.level11p62.rawValue,
                   ZeusImageName.level11p63.rawValue,
                   ZeusImageName.level11p64.rawValue,
                   ZeusImageName.level11p49.rawValue,
                   ZeusImageName.level11p50.rawValue,
                   ZeusImageName.level11p51.rawValue,
                   ZeusImageName.level11p52.rawValue,
                   ZeusImageName.level11p53.rawValue,
                   ZeusImageName.level11p54.rawValue,
                   ZeusImageName.level11p55.rawValue,
                   ZeusImageName.level11p56.rawValue,
                   ZeusImageName.level11p41.rawValue,
                   ZeusImageName.level11p42.rawValue,
                   ZeusImageName.level11p43.rawValue,
                   ZeusImageName.level11p44.rawValue,
                   ZeusImageName.level11p45.rawValue,
                   ZeusImageName.level11p46.rawValue,
                   ZeusImageName.level11p47.rawValue,
                   ZeusImageName.level11p48.rawValue,
                   ZeusImageName.level11p33.rawValue,
                   ZeusImageName.level11p34.rawValue,
                   ZeusImageName.level11p35.rawValue,
                   ZeusImageName.level11p36.rawValue,
                   ZeusImageName.level11p37.rawValue,
                   ZeusImageName.level11p38.rawValue,
                   ZeusImageName.level11p39.rawValue,
                   ZeusImageName.level11p40.rawValue,
                   ZeusImageName.level11p25.rawValue,
                   ZeusImageName.level11p26.rawValue,
                   ZeusImageName.level11p27.rawValue,
                   ZeusImageName.level11p28.rawValue,
                   ZeusImageName.level11p29.rawValue,
                   ZeusImageName.level11p30.rawValue,
                   ZeusImageName.level11p31.rawValue,
                   ZeusImageName.level11p32.rawValue,
                   ZeusImageName.level11p17.rawValue,
                   ZeusImageName.level11p18.rawValue,
                   ZeusImageName.level11p19.rawValue,
                   ZeusImageName.level11p20.rawValue,
                   ZeusImageName.level11p21.rawValue,
                   ZeusImageName.level11p22.rawValue,
                   ZeusImageName.level11p23.rawValue,
                   ZeusImageName.level11p24.rawValue,
                   ZeusImageName.level11p9.rawValue,
                   ZeusImageName.level11p10.rawValue,
                   ZeusImageName.level11p11.rawValue,
                   ZeusImageName.level11p12.rawValue,
                   ZeusImageName.level11p13.rawValue,
                   ZeusImageName.level11p14.rawValue,
                   ZeusImageName.level11p15.rawValue,
                   ZeusImageName.level11p16.rawValue,
                   ZeusImageName.level11p1.rawValue,
                   ZeusImageName.level11p2.rawValue,
                   ZeusImageName.level11p3.rawValue,
                   ZeusImageName.level11p4.rawValue,
                   ZeusImageName.level11p5.rawValue,
                   ZeusImageName.level11p6.rawValue,
                   ZeusImageName.level11p7.rawValue,
                   ZeusImageName.level11p8.rawValue
               ].shuffled()
            
        case 12:
            return [
                   ZeusImageName.level12p57.rawValue,
                   ZeusImageName.level12p58.rawValue,
                   ZeusImageName.level12p59.rawValue,
                   ZeusImageName.level12p60.rawValue,
                   ZeusImageName.level12p61.rawValue,
                   ZeusImageName.level12p62.rawValue,
                   ZeusImageName.level12p63.rawValue,
                   ZeusImageName.level12p64.rawValue,
                   ZeusImageName.level12p49.rawValue,
                   ZeusImageName.level12p50.rawValue,
                   ZeusImageName.level12p51.rawValue,
                   ZeusImageName.level12p52.rawValue,
                   ZeusImageName.level12p53.rawValue,
                   ZeusImageName.level12p54.rawValue,
                   ZeusImageName.level12p55.rawValue,
                   ZeusImageName.level12p56.rawValue,
                   ZeusImageName.level12p41.rawValue,
                   ZeusImageName.level12p42.rawValue,
                   ZeusImageName.level12p43.rawValue,
                   ZeusImageName.level12p44.rawValue,
                   ZeusImageName.level12p45.rawValue,
                   ZeusImageName.level12p46.rawValue,
                   ZeusImageName.level12p47.rawValue,
                   ZeusImageName.level12p48.rawValue,
                   ZeusImageName.level12p33.rawValue,
                   ZeusImageName.level12p34.rawValue,
                   ZeusImageName.level12p35.rawValue,
                   ZeusImageName.level12p36.rawValue,
                   ZeusImageName.level12p37.rawValue,
                   ZeusImageName.level12p38.rawValue,
                   ZeusImageName.level12p39.rawValue,
                   ZeusImageName.level12p40.rawValue,
                   ZeusImageName.level12p25.rawValue,
                   ZeusImageName.level12p26.rawValue,
                   ZeusImageName.level12p27.rawValue,
                   ZeusImageName.level12p28.rawValue,
                   ZeusImageName.level12p29.rawValue,
                   ZeusImageName.level12p30.rawValue,
                   ZeusImageName.level12p31.rawValue,
                   ZeusImageName.level12p32.rawValue,
                   ZeusImageName.level12p17.rawValue,
                   ZeusImageName.level12p18.rawValue,
                   ZeusImageName.level12p19.rawValue,
                   ZeusImageName.level12p20.rawValue,
                   ZeusImageName.level12p21.rawValue,
                   ZeusImageName.level12p22.rawValue,
                   ZeusImageName.level12p23.rawValue,
                   ZeusImageName.level12p24.rawValue,
                   ZeusImageName.level12p9.rawValue,
                   ZeusImageName.level12p10.rawValue,
                   ZeusImageName.level12p11.rawValue,
                   ZeusImageName.level12p12.rawValue,
                   ZeusImageName.level12p13.rawValue,
                   ZeusImageName.level12p14.rawValue,
                   ZeusImageName.level12p15.rawValue,
                   ZeusImageName.level12p16.rawValue,
                   ZeusImageName.level12p1.rawValue,
                   ZeusImageName.level12p2.rawValue,
                   ZeusImageName.level12p3.rawValue,
                   ZeusImageName.level12p4.rawValue,
                   ZeusImageName.level12p5.rawValue,
                   ZeusImageName.level12p6.rawValue,
                   ZeusImageName.level12p7.rawValue,
                   ZeusImageName.level12p8.rawValue
               ].shuffled()
        default:
            return [ZeusImageName.level1p1.rawValue,
                    ZeusImageName.level1p2.rawValue,
                    ZeusImageName.level1p3.rawValue,
                    ZeusImageName.level1p4.rawValue,
                    ZeusImageName.level1p5.rawValue,
                    ZeusImageName.level1p6.rawValue,
                    ZeusImageName.level1p7.rawValue,
                    ZeusImageName.level1p8.rawValue,
                    ZeusImageName.level1p9.rawValue,
                    ZeusImageName.level1p10.rawValue,
                    ZeusImageName.level1p11.rawValue,
                    ZeusImageName.level1p12.rawValue,
                    ZeusImageName.level1p13.rawValue,
                    ZeusImageName.level1p14.rawValue,
                    ZeusImageName.level1p15.rawValue,
                    ZeusImageName.level1p16.rawValue].shuffled()
        }
      
    }
    
    func returnRightPuzzles() -> [String] {
        switch level {
        case 1:
            return [ZeusImageName.level1p13.rawValue,
                    ZeusImageName.level1p14.rawValue,
                    ZeusImageName.level1p15.rawValue,
                    ZeusImageName.level1p16.rawValue,
                    ZeusImageName.level1p9.rawValue,
                    ZeusImageName.level1p10.rawValue,
                    ZeusImageName.level1p11.rawValue,
                    ZeusImageName.level1p12.rawValue,
                    ZeusImageName.level1p5.rawValue,
                    ZeusImageName.level1p6.rawValue,
                    ZeusImageName.level1p7.rawValue,
                    ZeusImageName.level1p8.rawValue,
                    ZeusImageName.level1p1.rawValue,
                    ZeusImageName.level1p2.rawValue,
                    ZeusImageName.level1p3.rawValue,
                    ZeusImageName.level1p4.rawValue]
            
        case 2:
            return [ZeusImageName.level2p13.rawValue,
                    ZeusImageName.level2p14.rawValue,
                    ZeusImageName.level2p15.rawValue,
                    ZeusImageName.level2p16.rawValue,
                    ZeusImageName.level2p9.rawValue,
                    ZeusImageName.level2p10.rawValue,
                    ZeusImageName.level2p11.rawValue,
                    ZeusImageName.level2p12.rawValue,
                    ZeusImageName.level2p5.rawValue,
                    ZeusImageName.level2p6.rawValue,
                    ZeusImageName.level2p7.rawValue,
                    ZeusImageName.level2p8.rawValue,
                    ZeusImageName.level2p1.rawValue,
                    ZeusImageName.level2p2.rawValue,
                    ZeusImageName.level2p3.rawValue,
                    ZeusImageName.level2p4.rawValue]
            
        case 3:
            return [ZeusImageName.level3p13.rawValue,
                    ZeusImageName.level3p14.rawValue,
                    ZeusImageName.level3p15.rawValue,
                    ZeusImageName.level3p16.rawValue,
                    ZeusImageName.level3p9.rawValue,
                    ZeusImageName.level3p10.rawValue,
                    ZeusImageName.level3p11.rawValue,
                    ZeusImageName.level3p12.rawValue,
                    ZeusImageName.level3p5.rawValue,
                    ZeusImageName.level3p6.rawValue,
                    ZeusImageName.level3p7.rawValue,
                    ZeusImageName.level3p8.rawValue,
                    ZeusImageName.level3p1.rawValue,
                    ZeusImageName.level3p2.rawValue,
                    ZeusImageName.level3p3.rawValue,
                    ZeusImageName.level3p4.rawValue]
            
        case 4:
            return [ZeusImageName.level4p13.rawValue,
                    ZeusImageName.level4p14.rawValue,
                    ZeusImageName.level4p15.rawValue,
                    ZeusImageName.level4p16.rawValue,
                    ZeusImageName.level4p9.rawValue,
                    ZeusImageName.level4p10.rawValue,
                    ZeusImageName.level4p11.rawValue,
                    ZeusImageName.level4p12.rawValue,
                    ZeusImageName.level4p5.rawValue,
                    ZeusImageName.level4p6.rawValue,
                    ZeusImageName.level4p7.rawValue,
                    ZeusImageName.level4p8.rawValue,
                    ZeusImageName.level4p1.rawValue,
                    ZeusImageName.level4p2.rawValue,
                    ZeusImageName.level4p3.rawValue,
                    ZeusImageName.level4p4.rawValue]
            
        case 5:
            return [ZeusImageName.level5p31.rawValue,
                    ZeusImageName.level5p32.rawValue,
                    ZeusImageName.level5p33.rawValue,
                    ZeusImageName.level5p34.rawValue,
                    ZeusImageName.level5p35.rawValue,
                    ZeusImageName.level5p36.rawValue,
                    ZeusImageName.level5p25.rawValue,
                    ZeusImageName.level5p26.rawValue,
                    ZeusImageName.level5p27.rawValue,
                    ZeusImageName.level5p28.rawValue,
                    ZeusImageName.level5p29.rawValue,
                    ZeusImageName.level5p30.rawValue,
                    ZeusImageName.level5p19.rawValue,
                    ZeusImageName.level5p20.rawValue,
                    ZeusImageName.level5p21.rawValue,
                    ZeusImageName.level5p22.rawValue,
                    ZeusImageName.level5p23.rawValue,
                    ZeusImageName.level5p24.rawValue,
                    ZeusImageName.level5p13.rawValue,
                    ZeusImageName.level5p14.rawValue,
                    ZeusImageName.level5p15.rawValue,
                    ZeusImageName.level5p16.rawValue,
                    ZeusImageName.level5p17.rawValue,
                    ZeusImageName.level5p18.rawValue,
                    ZeusImageName.level5p7.rawValue,
                    ZeusImageName.level5p8.rawValue,
                    ZeusImageName.level5p9.rawValue,
                    ZeusImageName.level5p10.rawValue,
                    ZeusImageName.level5p11.rawValue,
                    ZeusImageName.level5p12.rawValue,
                    ZeusImageName.level5p1.rawValue,
                    ZeusImageName.level5p2.rawValue,
                    ZeusImageName.level5p3.rawValue,
                    ZeusImageName.level5p4.rawValue,
                    ZeusImageName.level5p5.rawValue,
                    ZeusImageName.level5p6.rawValue]
        case 6:
            return [ZeusImageName.level6p31.rawValue,
                    ZeusImageName.level6p32.rawValue,
                    ZeusImageName.level6p33.rawValue,
                    ZeusImageName.level6p34.rawValue,
                    ZeusImageName.level6p35.rawValue,
                    ZeusImageName.level6p36.rawValue,
                    ZeusImageName.level6p25.rawValue,
                    ZeusImageName.level6p26.rawValue,
                    ZeusImageName.level6p27.rawValue,
                    ZeusImageName.level6p28.rawValue,
                    ZeusImageName.level6p29.rawValue,
                    ZeusImageName.level6p30.rawValue,
                    ZeusImageName.level6p19.rawValue,
                    ZeusImageName.level6p20.rawValue,
                    ZeusImageName.level6p21.rawValue,
                    ZeusImageName.level6p22.rawValue,
                    ZeusImageName.level6p23.rawValue,
                    ZeusImageName.level6p24.rawValue,
                    ZeusImageName.level6p13.rawValue,
                    ZeusImageName.level6p14.rawValue,
                    ZeusImageName.level6p15.rawValue,
                    ZeusImageName.level6p16.rawValue,
                    ZeusImageName.level6p17.rawValue,
                    ZeusImageName.level6p18.rawValue,
                    ZeusImageName.level6p7.rawValue,
                    ZeusImageName.level6p8.rawValue,
                    ZeusImageName.level6p9.rawValue,
                    ZeusImageName.level6p10.rawValue,
                    ZeusImageName.level6p11.rawValue,
                    ZeusImageName.level6p12.rawValue,
                    ZeusImageName.level6p1.rawValue,
                    ZeusImageName.level6p2.rawValue,
                    ZeusImageName.level6p3.rawValue,
                    ZeusImageName.level6p4.rawValue,
                    ZeusImageName.level6p5.rawValue,
                    ZeusImageName.level6p6.rawValue]
            
        case 7:
            return [ZeusImageName.level7p31.rawValue,
                    ZeusImageName.level7p32.rawValue,
                    ZeusImageName.level7p33.rawValue,
                    ZeusImageName.level7p34.rawValue,
                    ZeusImageName.level7p35.rawValue,
                    ZeusImageName.level7p36.rawValue,
                    ZeusImageName.level7p25.rawValue,
                    ZeusImageName.level7p26.rawValue,
                    ZeusImageName.level7p27.rawValue,
                    ZeusImageName.level7p28.rawValue,
                    ZeusImageName.level7p29.rawValue,
                    ZeusImageName.level7p30.rawValue,
                    ZeusImageName.level7p19.rawValue,
                    ZeusImageName.level7p20.rawValue,
                    ZeusImageName.level7p21.rawValue,
                    ZeusImageName.level7p22.rawValue,
                    ZeusImageName.level7p23.rawValue,
                    ZeusImageName.level7p24.rawValue,
                    ZeusImageName.level7p13.rawValue,
                    ZeusImageName.level7p14.rawValue,
                    ZeusImageName.level7p15.rawValue,
                    ZeusImageName.level7p16.rawValue,
                    ZeusImageName.level7p17.rawValue,
                    ZeusImageName.level7p18.rawValue,
                    ZeusImageName.level7p7.rawValue,
                    ZeusImageName.level7p8.rawValue,
                    ZeusImageName.level7p9.rawValue,
                    ZeusImageName.level7p10.rawValue,
                    ZeusImageName.level7p11.rawValue,
                    ZeusImageName.level7p12.rawValue,
                    ZeusImageName.level7p1.rawValue,
                    ZeusImageName.level7p2.rawValue,
                    ZeusImageName.level7p3.rawValue,
                    ZeusImageName.level7p4.rawValue,
                    ZeusImageName.level7p5.rawValue,
                    ZeusImageName.level7p6.rawValue]
            
        case 8:
            return [ZeusImageName.level8p31.rawValue,
                    ZeusImageName.level8p32.rawValue,
                    ZeusImageName.level8p33.rawValue,
                    ZeusImageName.level8p34.rawValue,
                    ZeusImageName.level8p35.rawValue,
                    ZeusImageName.level8p36.rawValue,
                    ZeusImageName.level8p25.rawValue,
                    ZeusImageName.level8p26.rawValue,
                    ZeusImageName.level8p27.rawValue,
                    ZeusImageName.level8p28.rawValue,
                    ZeusImageName.level8p29.rawValue,
                    ZeusImageName.level8p30.rawValue,
                    ZeusImageName.level8p19.rawValue,
                    ZeusImageName.level8p20.rawValue,
                    ZeusImageName.level8p21.rawValue,
                    ZeusImageName.level8p22.rawValue,
                    ZeusImageName.level8p23.rawValue,
                    ZeusImageName.level8p24.rawValue,
                    ZeusImageName.level8p13.rawValue,
                    ZeusImageName.level8p14.rawValue,
                    ZeusImageName.level8p15.rawValue,
                    ZeusImageName.level8p16.rawValue,
                    ZeusImageName.level8p17.rawValue,
                    ZeusImageName.level8p18.rawValue,
                    ZeusImageName.level8p7.rawValue,
                    ZeusImageName.level8p8.rawValue,
                    ZeusImageName.level8p9.rawValue,
                    ZeusImageName.level8p10.rawValue,
                    ZeusImageName.level8p11.rawValue,
                    ZeusImageName.level8p12.rawValue,
                    ZeusImageName.level8p1.rawValue,
                    ZeusImageName.level8p2.rawValue,
                    ZeusImageName.level8p3.rawValue,
                    ZeusImageName.level8p4.rawValue,
                    ZeusImageName.level8p5.rawValue,
                    ZeusImageName.level8p6.rawValue]
            
        case 9:
            return [
                   ZeusImageName.level9p57.rawValue,
                   ZeusImageName.level9p58.rawValue,
                   ZeusImageName.level9p59.rawValue,
                   ZeusImageName.level9p60.rawValue,
                   ZeusImageName.level9p61.rawValue,
                   ZeusImageName.level9p62.rawValue,
                   ZeusImageName.level9p63.rawValue,
                   ZeusImageName.level9p64.rawValue,
                   
                   ZeusImageName.level9p49.rawValue,
                   ZeusImageName.level9p50.rawValue,
                   ZeusImageName.level9p51.rawValue,
                   ZeusImageName.level9p52.rawValue,
                   ZeusImageName.level9p53.rawValue,
                   ZeusImageName.level9p54.rawValue,
                   ZeusImageName.level9p55.rawValue,
                   ZeusImageName.level9p56.rawValue,
                   
                   ZeusImageName.level9p41.rawValue,
                   ZeusImageName.level9p42.rawValue,
                   ZeusImageName.level9p43.rawValue,
                   ZeusImageName.level9p44.rawValue,
                   ZeusImageName.level9p45.rawValue,
                   ZeusImageName.level9p46.rawValue,
                   ZeusImageName.level9p47.rawValue,
                   ZeusImageName.level9p48.rawValue,
                   
                   ZeusImageName.level9p33.rawValue,
                   ZeusImageName.level9p34.rawValue,
                   ZeusImageName.level9p35.rawValue,
                   ZeusImageName.level9p36.rawValue,
                   ZeusImageName.level9p37.rawValue,
                   ZeusImageName.level9p38.rawValue,
                   ZeusImageName.level9p39.rawValue,
                   ZeusImageName.level9p40.rawValue,
                   
                   ZeusImageName.level9p25.rawValue,
                   ZeusImageName.level9p26.rawValue,
                   ZeusImageName.level9p27.rawValue,
                   ZeusImageName.level9p28.rawValue,
                   ZeusImageName.level9p29.rawValue,
                   ZeusImageName.level9p30.rawValue,
                   ZeusImageName.level9p31.rawValue,
                   ZeusImageName.level9p32.rawValue,
                   
                   ZeusImageName.level9p17.rawValue,
                   ZeusImageName.level9p18.rawValue,
                   ZeusImageName.level9p19.rawValue,
                   ZeusImageName.level9p20.rawValue,
                   ZeusImageName.level9p21.rawValue,
                   ZeusImageName.level9p22.rawValue,
                   ZeusImageName.level9p23.rawValue,
                   ZeusImageName.level9p24.rawValue,
                   
                   ZeusImageName.level9p9.rawValue,
                   ZeusImageName.level9p10.rawValue,
                   ZeusImageName.level9p11.rawValue,
                   ZeusImageName.level9p12.rawValue,
                   ZeusImageName.level9p13.rawValue,
                   ZeusImageName.level9p14.rawValue,
                   ZeusImageName.level9p15.rawValue,
                   ZeusImageName.level9p16.rawValue,
                   
                   ZeusImageName.level9p1.rawValue,
                   ZeusImageName.level9p2.rawValue,
                   ZeusImageName.level9p3.rawValue,
                   ZeusImageName.level9p4.rawValue,
                   ZeusImageName.level9p5.rawValue,
                   ZeusImageName.level9p6.rawValue,
                   ZeusImageName.level9p7.rawValue,
                   ZeusImageName.level9p8.rawValue
               ]
        case 10:
            return [
                   ZeusImageName.level10p57.rawValue,
                   ZeusImageName.level10p58.rawValue,
                   ZeusImageName.level10p59.rawValue,
                   ZeusImageName.level10p60.rawValue,
                   ZeusImageName.level10p61.rawValue,
                   ZeusImageName.level10p62.rawValue,
                   ZeusImageName.level10p63.rawValue,
                   ZeusImageName.level10p64.rawValue,
                   ZeusImageName.level10p49.rawValue,
                   ZeusImageName.level10p50.rawValue,
                   ZeusImageName.level10p51.rawValue,
                   ZeusImageName.level10p52.rawValue,
                   ZeusImageName.level10p53.rawValue,
                   ZeusImageName.level10p54.rawValue,
                   ZeusImageName.level10p55.rawValue,
                   ZeusImageName.level10p56.rawValue,
                   ZeusImageName.level10p41.rawValue,
                   ZeusImageName.level10p42.rawValue,
                   ZeusImageName.level10p43.rawValue,
                   ZeusImageName.level10p44.rawValue,
                   ZeusImageName.level10p45.rawValue,
                   ZeusImageName.level10p46.rawValue,
                   ZeusImageName.level10p47.rawValue,
                   ZeusImageName.level10p48.rawValue,
                   ZeusImageName.level10p33.rawValue,
                   ZeusImageName.level10p34.rawValue,
                   ZeusImageName.level10p35.rawValue,
                   ZeusImageName.level10p36.rawValue,
                   ZeusImageName.level10p37.rawValue,
                   ZeusImageName.level10p38.rawValue,
                   ZeusImageName.level10p39.rawValue,
                   ZeusImageName.level10p40.rawValue,
                   ZeusImageName.level10p25.rawValue,
                   ZeusImageName.level10p26.rawValue,
                   ZeusImageName.level10p27.rawValue,
                   ZeusImageName.level10p28.rawValue,
                   ZeusImageName.level10p29.rawValue,
                   ZeusImageName.level10p30.rawValue,
                   ZeusImageName.level10p31.rawValue,
                   ZeusImageName.level10p32.rawValue,
                   ZeusImageName.level10p17.rawValue,
                   ZeusImageName.level10p18.rawValue,
                   ZeusImageName.level10p19.rawValue,
                   ZeusImageName.level10p20.rawValue,
                   ZeusImageName.level10p21.rawValue,
                   ZeusImageName.level10p22.rawValue,
                   ZeusImageName.level10p23.rawValue,
                   ZeusImageName.level10p24.rawValue,
                   ZeusImageName.level10p9.rawValue,
                   ZeusImageName.level10p10.rawValue,
                   ZeusImageName.level10p11.rawValue,
                   ZeusImageName.level10p12.rawValue,
                   ZeusImageName.level10p13.rawValue,
                   ZeusImageName.level10p14.rawValue,
                   ZeusImageName.level10p15.rawValue,
                   ZeusImageName.level10p16.rawValue,
                   ZeusImageName.level10p1.rawValue,
                   ZeusImageName.level10p2.rawValue,
                   ZeusImageName.level10p3.rawValue,
                   ZeusImageName.level10p4.rawValue,
                   ZeusImageName.level10p5.rawValue,
                   ZeusImageName.level10p6.rawValue,
                   ZeusImageName.level10p7.rawValue,
                   ZeusImageName.level10p8.rawValue
               ]
            
        case 11:
            return [
                   ZeusImageName.level11p57.rawValue,
                   ZeusImageName.level11p58.rawValue,
                   ZeusImageName.level11p59.rawValue,
                   ZeusImageName.level11p60.rawValue,
                   ZeusImageName.level11p61.rawValue,
                   ZeusImageName.level11p62.rawValue,
                   ZeusImageName.level11p63.rawValue,
                   ZeusImageName.level11p64.rawValue,
                   ZeusImageName.level11p49.rawValue,
                   ZeusImageName.level11p50.rawValue,
                   ZeusImageName.level11p51.rawValue,
                   ZeusImageName.level11p52.rawValue,
                   ZeusImageName.level11p53.rawValue,
                   ZeusImageName.level11p54.rawValue,
                   ZeusImageName.level11p55.rawValue,
                   ZeusImageName.level11p56.rawValue,
                   ZeusImageName.level11p41.rawValue,
                   ZeusImageName.level11p42.rawValue,
                   ZeusImageName.level11p43.rawValue,
                   ZeusImageName.level11p44.rawValue,
                   ZeusImageName.level11p45.rawValue,
                   ZeusImageName.level11p46.rawValue,
                   ZeusImageName.level11p47.rawValue,
                   ZeusImageName.level11p48.rawValue,
                   ZeusImageName.level11p33.rawValue,
                   ZeusImageName.level11p34.rawValue,
                   ZeusImageName.level11p35.rawValue,
                   ZeusImageName.level11p36.rawValue,
                   ZeusImageName.level11p37.rawValue,
                   ZeusImageName.level11p38.rawValue,
                   ZeusImageName.level11p39.rawValue,
                   ZeusImageName.level11p40.rawValue,
                   ZeusImageName.level11p25.rawValue,
                   ZeusImageName.level11p26.rawValue,
                   ZeusImageName.level11p27.rawValue,
                   ZeusImageName.level11p28.rawValue,
                   ZeusImageName.level11p29.rawValue,
                   ZeusImageName.level11p30.rawValue,
                   ZeusImageName.level11p31.rawValue,
                   ZeusImageName.level11p32.rawValue,
                   ZeusImageName.level11p17.rawValue,
                   ZeusImageName.level11p18.rawValue,
                   ZeusImageName.level11p19.rawValue,
                   ZeusImageName.level11p20.rawValue,
                   ZeusImageName.level11p21.rawValue,
                   ZeusImageName.level11p22.rawValue,
                   ZeusImageName.level11p23.rawValue,
                   ZeusImageName.level11p24.rawValue,
                   ZeusImageName.level11p9.rawValue,
                   ZeusImageName.level11p10.rawValue,
                   ZeusImageName.level11p11.rawValue,
                   ZeusImageName.level11p12.rawValue,
                   ZeusImageName.level11p13.rawValue,
                   ZeusImageName.level11p14.rawValue,
                   ZeusImageName.level11p15.rawValue,
                   ZeusImageName.level11p16.rawValue,
                   ZeusImageName.level11p1.rawValue,
                   ZeusImageName.level11p2.rawValue,
                   ZeusImageName.level11p3.rawValue,
                   ZeusImageName.level11p4.rawValue,
                   ZeusImageName.level11p5.rawValue,
                   ZeusImageName.level11p6.rawValue,
                   ZeusImageName.level11p7.rawValue,
                   ZeusImageName.level11p8.rawValue
               ]
            
        case 12:
            return [
                   ZeusImageName.level12p57.rawValue,
                   ZeusImageName.level12p58.rawValue,
                   ZeusImageName.level12p59.rawValue,
                   ZeusImageName.level12p60.rawValue,
                   ZeusImageName.level12p61.rawValue,
                   ZeusImageName.level12p62.rawValue,
                   ZeusImageName.level12p63.rawValue,
                   ZeusImageName.level12p64.rawValue,
                   ZeusImageName.level12p49.rawValue,
                   ZeusImageName.level12p50.rawValue,
                   ZeusImageName.level12p51.rawValue,
                   ZeusImageName.level12p52.rawValue,
                   ZeusImageName.level12p53.rawValue,
                   ZeusImageName.level12p54.rawValue,
                   ZeusImageName.level12p55.rawValue,
                   ZeusImageName.level12p56.rawValue,
                   ZeusImageName.level12p41.rawValue,
                   ZeusImageName.level12p42.rawValue,
                   ZeusImageName.level12p43.rawValue,
                   ZeusImageName.level12p44.rawValue,
                   ZeusImageName.level12p45.rawValue,
                   ZeusImageName.level12p46.rawValue,
                   ZeusImageName.level12p47.rawValue,
                   ZeusImageName.level12p48.rawValue,
                   ZeusImageName.level12p33.rawValue,
                   ZeusImageName.level12p34.rawValue,
                   ZeusImageName.level12p35.rawValue,
                   ZeusImageName.level12p36.rawValue,
                   ZeusImageName.level12p37.rawValue,
                   ZeusImageName.level12p38.rawValue,
                   ZeusImageName.level12p39.rawValue,
                   ZeusImageName.level12p40.rawValue,
                   ZeusImageName.level12p25.rawValue,
                   ZeusImageName.level12p26.rawValue,
                   ZeusImageName.level12p27.rawValue,
                   ZeusImageName.level12p28.rawValue,
                   ZeusImageName.level12p29.rawValue,
                   ZeusImageName.level12p30.rawValue,
                   ZeusImageName.level12p31.rawValue,
                   ZeusImageName.level12p32.rawValue,
                   ZeusImageName.level12p17.rawValue,
                   ZeusImageName.level12p18.rawValue,
                   ZeusImageName.level12p19.rawValue,
                   ZeusImageName.level12p20.rawValue,
                   ZeusImageName.level12p21.rawValue,
                   ZeusImageName.level12p22.rawValue,
                   ZeusImageName.level12p23.rawValue,
                   ZeusImageName.level12p24.rawValue,
                   ZeusImageName.level12p9.rawValue,
                   ZeusImageName.level12p10.rawValue,
                   ZeusImageName.level12p11.rawValue,
                   ZeusImageName.level12p12.rawValue,
                   ZeusImageName.level12p13.rawValue,
                   ZeusImageName.level12p14.rawValue,
                   ZeusImageName.level12p15.rawValue,
                   ZeusImageName.level12p16.rawValue,
                   ZeusImageName.level12p1.rawValue,
                   ZeusImageName.level12p2.rawValue,
                   ZeusImageName.level12p3.rawValue,
                   ZeusImageName.level12p4.rawValue,
                   ZeusImageName.level12p5.rawValue,
                   ZeusImageName.level12p6.rawValue,
                   ZeusImageName.level12p7.rawValue,
                   ZeusImageName.level12p8.rawValue
               ]
        default:
            return [ZeusImageName.level1p1.rawValue,
                    ZeusImageName.level1p2.rawValue,
                    ZeusImageName.level1p3.rawValue,
                    ZeusImageName.level1p4.rawValue,
                    ZeusImageName.level1p5.rawValue,
                    ZeusImageName.level1p6.rawValue,
                    ZeusImageName.level1p7.rawValue,
                    ZeusImageName.level1p8.rawValue,
                    ZeusImageName.level1p9.rawValue,
                    ZeusImageName.level1p10.rawValue,
                    ZeusImageName.level1p11.rawValue,
                    ZeusImageName.level1p12.rawValue,
                    ZeusImageName.level1p13.rawValue,
                    ZeusImageName.level1p14.rawValue,
                    ZeusImageName.level1p15.rawValue,
                    ZeusImageName.level1p16.rawValue]
        }
    }
    
    func createGrid() {
        if level > 0, level <= 4 {
            gridSize = 4
            let puzzleSize = size.width * 0.15
            let puzzleImages = returnAllPuzzles()
            for row in 0..<gridSize {
                var puzzleRow: [SKSpriteNode] = []
                for column in 0..<gridSize {
                    let puzzle = SKSpriteNode(imageNamed: puzzleImages[row * gridSize + column])
                    puzzle.size = CGSize(width: puzzleSize, height: puzzleSize)
                    puzzle.position = CGPoint(
                        x: CGFloat(column) * (puzzleSize + 20) + puzzleSize * 1.35,
                        y: CGFloat(row) * (puzzleSize + 20) + puzzleSize / 0.233
                    )
                    puzzle.name = "\(puzzleImages[row * gridSize + column])"
                    let border = SKShapeNode(rectOf: CGSize(width: puzzleSize, height: puzzleSize))
                    border.strokeColor = .white
                    border.lineWidth = 2
                    border.name = "border"
                    border.position = CGPoint(x: 0, y: 0)
                    border.isUserInteractionEnabled = false
                    puzzle.addChild(border)
                    addChild(puzzle)
                    puzzleRow.append(puzzle)
                }
                puzzles.append(puzzleRow)
            }
            updateBordersForCorrectPositions()
        } else if level > 4, level <= 8 {
            gridSize = 6
            let puzzleSize = size.width * 0.1
            let puzzleImages = returnAllPuzzles()
            for row in 0..<gridSize {
                var puzzleRow: [SKSpriteNode] = []
                for column in 0..<gridSize {
                    let puzzle = SKSpriteNode(imageNamed: puzzleImages[row * gridSize + column])
                    puzzle.size = CGSize(width: puzzleSize, height: puzzleSize)
                    puzzle.position = CGPoint(
                        x: CGFloat(column) * (puzzleSize + 15) + puzzleSize * 1.6,
                        y: CGFloat(row) * (puzzleSize + 15) + puzzleSize / 0.165
                    )
                    puzzle.name = "\(puzzleImages[row * gridSize + column])"
                    let border = SKShapeNode(rectOf: CGSize(width: puzzleSize, height: puzzleSize))
                    border.strokeColor = .white
                    border.lineWidth = 2
                    border.name = "border"
                    border.position = CGPoint(x: 0, y: 0)
                    border.isUserInteractionEnabled = false
                    puzzle.addChild(border)
                    addChild(puzzle)
                    puzzleRow.append(puzzle)
                }
                puzzles.append(puzzleRow)
            }
            updateBordersForCorrectPositions()
        } else if level > 8, level <= 12 {
            gridSize = 8
            let puzzleSize = size.width * 0.075
            let puzzleImages = returnAllPuzzles()
            for row in 0..<gridSize {
                var puzzleRow: [SKSpriteNode] = []
                for column in 0..<gridSize {
                    let puzzle = SKSpriteNode(imageNamed: puzzleImages[row * gridSize + column])
                    puzzle.size = CGSize(width: puzzleSize, height: puzzleSize)
                    puzzle.position = CGPoint(
                        x: CGFloat(column) * (puzzleSize + 10) + puzzleSize * 2,
                        y: CGFloat(row) * (puzzleSize + 10) + puzzleSize / 0.125
                    )
                    puzzle.name = "\(puzzleImages[row * gridSize + column])"
                    let border = SKShapeNode(rectOf: CGSize(width: puzzleSize, height: puzzleSize))
                    border.strokeColor = .white
                    border.lineWidth = 2
                    border.name = "border"
                    border.position = CGPoint(x: 0, y: 0)
                    border.isUserInteractionEnabled = false
                    puzzle.addChild(border)
                    addChild(puzzle)
                    puzzleRow.append(puzzle)
                }
                puzzles.append(puzzleRow)
            }
        }
    }

    func setupView() {
        createMainView()
        createTappedView()
        createMutatingView()
        startTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
        
        if let tappedNode = touchedNode as? SKSpriteNode {
            if tappedNode.name == "bonusClueButton" {
                let clueCount = UserDefaultsManager.defaults.integer(forKey: Keys.clueCount.rawValue)
                if clueCount > 0 {
                    UserDefaultsManager().useBonus(key: Keys.clueCount.rawValue)
                    moveOnePuzzleToCorrectPosition()
                    bonusClueCount.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.clueCount.rawValue) ?? 0)", attributes: [
                        NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 26)!,
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
                        NSAttributedString.Key.strokeWidth: -3
                    ])
                }
                return
            } else if tappedNode.name == "pause" {
                game?.isPause = true
                return
            } else if tappedNode.name == "rules" {
                game?.isRules = true
                return
            } else if tappedNode.name == "bonusButton" {
                let timeCount = UserDefaultsManager.defaults.integer(forKey: Keys.timeCount.rawValue)
                if timeCount > 0 {
                    UserDefaultsManager().useBonus(key: Keys.timeCount.rawValue)
                    game!.timeLeft += 20
                    bonusTimeCount.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.timeCount.rawValue) ?? 0)", attributes: [
                        NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 26)!,
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
                        NSAttributedString.Key.strokeWidth: -3
                    ])
                }
                return
            }
        }
        
        var tappedPuzzle: SKSpriteNode?
        if let node = touchedNode as? SKShapeNode {
            tappedPuzzle = node.parent as? SKSpriteNode
        } else if let node = touchedNode as? SKSpriteNode {
            tappedPuzzle = node
        }
        
        guard let tappedPuzzle = tappedPuzzle, tappedPuzzle.name?.contains("level") == true else {
            return
        }
        if let border = tappedPuzzle.childNode(withName: "border") as? SKShapeNode, border.strokeColor == .yellow {
            return
        }
        
        if let selected = selectedPuzzle {
            if let selectedBorder = selected.childNode(withName: "border") as? SKShapeNode, selectedBorder.strokeColor == .yellow {
                return
            }
            
            let isCorrectlyPlacedBeforeSwap = isPuzzleCorrectlyPlaced(tappedPuzzle)
            
            if selected == tappedPuzzle {
                selectedPuzzle = nil
                removeBlackBorder(from: selected)
            } else {
                swapPuzzles(selected, tappedPuzzle)
                selectedPuzzle = nil
                removeBlackBorder(from: selected)
                
                if isPuzzleCorrectlyPlaced(tappedPuzzle) && !isCorrectlyPlacedBeforeSwap {
                    game?.score += 100
                    updateScoreLabel()
                }
            }
        } else {
            selectedPuzzle = tappedPuzzle
            addBlackBorder(to: tappedPuzzle)
        }
        
        checkWinCondition()
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        setupView()
        correctPuzzleArrangement = returnRightPuzzles()
        createGrid()
    }
}
struct ZeusGameView: View {
    @StateObject var zeusGameModel =  ZeusGameViewModel()
    @StateObject var gameModel =  ZeusGameData()
    var level: Int
    
    var body: some View {
        ZStack {
            SpriteView(scene: zeusGameModel.createZeusGameScene(gameData: gameModel, level: level))
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            if gameModel.isPause {
                ZeusPauseView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isRules {
                ZeusRulesView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isWin {
                ZeusWinView(score: gameModel.score, level: level)
                    .onAppear {
                        UserDefaultsManager().completeLevel()
                    }
            }
            
            if gameModel.isLose {
                ZeusLoseView(score: gameModel.score, level: level)
            }
        }
    }
}

#Preview {
    ZeusGameView(level: 1)
}

