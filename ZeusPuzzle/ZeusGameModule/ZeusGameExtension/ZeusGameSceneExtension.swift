import SwiftUI
import SpriteKit

extension ZeusGameSpriteKit {
    
 

 

    func createMutatingView() {
        let rulesButton = SKSpriteNode(imageNamed: ZeusImageName.roundedSilver.rawValue)
        rulesButton.size = CGSize(width: size.width * 0.41, height: size.height * 0.079)
        rulesButton.position = CGPoint(x: size.width / 2, y: size.height / 1.17)
        addChild(rulesButton)
        
        let levelLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        levelLabel.attributedText = NSAttributedString(string: "LEVEL \(level)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.076)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -3.5
        ])
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.195)
        addChild(levelLabel)
        
        let coinBack = SKSpriteNode(imageNamed: ZeusImageName.goldBack.rawValue)
        coinBack.size = CGSize(width: size.width * 0.23, height: size.height * 0.06)
        coinBack.position = CGPoint(x: size.width / 6, y: size.height / 1.23)
        addChild(coinBack)
        
        let coinLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        coinLabel.attributedText = NSAttributedString(string: "COIN", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.035)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -4
        ])
        coinLabel.position = CGPoint(x: size.width / 6.3, y: size.height / 1.228)
        addChild(coinLabel)
        
        let coinCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        coinCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.money.rawValue) ?? 0)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.06)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        coinCountLabel.position = CGPoint(x: size.width / 6.1, y: size.height / 1.267)
        addChild(coinCountLabel)
        
        let scoreBack = SKSpriteNode(imageNamed: ZeusImageName.goldBack.rawValue)
        scoreBack.size = CGSize(width: size.width * 0.23, height: size.height * 0.06)
        scoreBack.position = CGPoint(x: size.width / 6, y: size.height / 1.34)
        addChild(scoreBack)
        
        let scoreLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        scoreLabel.attributedText = NSAttributedString(string: "SCORE", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.035)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -4
        ])
        scoreLabel.position = CGPoint(x: size.width / 6.1, y: size.height / 1.337)
        addChild(scoreLabel)
        
        scoreCountLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        scoreCountLabel.attributedText = NSAttributedString(string: "\(game!.score)/1000", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.045)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        scoreCountLabel.position = CGPoint(x: size.width / 6.1, y: size.height / 1.377)
        addChild(scoreCountLabel)
        
        timeLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        timeLabel.attributedText = NSAttributedString(string: "\(String(describing: game!.timeLeft / 60)):\(String(describing: game!.timeLeft % 60))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: size.width * 0.097)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
        timeLabel.position = CGPoint(x: size.width / 1.3, y: size.height / 1.355)
        addChild(timeLabel)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            if !(self.game?.isRules ?? false) && !(self.game?.isPause ?? false) && !(game?.isWin ?? false) && !(game?.isLose ?? false) {
                self.updateTimer()
            }
        }
    }
    
    func updateTimer() {
        if game?.timeLeft ?? 0 > 0 {
            game?.timeLeft -= 1
            timeLabel.attributedText = NSAttributedString(string: "\(String(describing: game!.timeLeft / 60)):\(String(describing: game!.timeLeft % 60))", attributes: [
                NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 38)!,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
                NSAttributedString.Key.strokeWidth: -5
            ])
        } else {
            if game!.isWin != true {
                game?.isLose = true
                timer?.invalidate()
            }
        }
    }
    
    func moveOnePuzzleToCorrectPosition() {
        if let incorrectPuzzle = findIncorrectPuzzle() {
            if let correctIndex = correctPuzzleIndex(for: incorrectPuzzle) {
                let correctRow = correctIndex.row
                let correctColumn = correctIndex.column
                let correctPuzzle = puzzles[correctRow][correctColumn]
                swapPuzzles(incorrectPuzzle, correctPuzzle)
                updateBordersForCorrectPositions()
                game?.score += 100
                updateScoreLabel()
                checkWinCondition()
            }
        }
    }
    
    func findIncorrectPuzzle() -> SKSpriteNode? {
        for row in 0..<gridSize {
            for column in 0..<gridSize {
                let puzzle = puzzles[row][column]
                let puzzleName = puzzle.name ?? ""
                let correctName = correctPuzzleArrangement[row * gridSize + column]
                
                if puzzleName != correctName {
                    return puzzle
                }
            }
        }
        return nil
    }
    
    func correctPuzzleIndex(for puzzle: SKSpriteNode) -> (row: Int, column: Int)? {
        guard let puzzleName = puzzle.name else { return nil }
        for row in 0..<gridSize {
            for column in 0..<gridSize {
                if correctPuzzleArrangement[row * gridSize + column] == puzzleName {
                    return (row: row, column: column)
                }
            }
        }
        return nil
    }
    
    func addBlackBorder(to puzzle: SKSpriteNode) {
        let border = SKShapeNode(rectOf: CGSize(width: puzzleSize, height: puzzleSize))
        border.strokeColor = .black
        border.lineWidth = 2
        border.name = "selectedBorder"
        border.zPosition = 1
        border.isUserInteractionEnabled = false
        puzzle.addChild(border)
    }
    
    func removeBlackBorder(from puzzle: SKSpriteNode) {
        puzzle.childNode(withName: "selectedBorder")?.removeFromParent()
    }
    
    func updateBordersForCorrectPositions() {
        let correctArrangement = returnRightPuzzles()
        for row in 0..<gridSize {
            for column in 0..<gridSize {
                let puzzle = puzzles[row][column]
                let puzzleName = puzzle.name ?? ""
                let correctName = correctArrangement[row * gridSize + column]
                if puzzleName == correctName {
                    if let border = puzzle.childNode(withName: "border") as? SKShapeNode {
                        border.strokeColor = .yellow
                    }
                } else {
                    if let border = puzzle.childNode(withName: "border") as? SKShapeNode {
                        border.strokeColor = .white
                    }
                }
            }
        }
    }
    
    func checkWinCondition() {
        let currentArrangement = puzzles.flatMap { $0.map { $0.name ?? "" } }
        let isWin = currentArrangement == correctPuzzleArrangement
        if isWin {
            game?.isWin = true
        }
    }
    
    func swapPuzzles(_ first: SKSpriteNode, _ second: SKSpriteNode) {
        guard let firstIndex = indexOfPuzzle(first), let secondIndex = indexOfPuzzle(second) else {
            return
        }
        
        let firstPosition = first.position
        let secondPosition = second.position
        first.position = secondPosition
        second.position = firstPosition
        let temp = puzzles[firstIndex.row][firstIndex.column]
        puzzles[firstIndex.row][firstIndex.column] = puzzles[secondIndex.row][secondIndex.column]
        puzzles[secondIndex.row][secondIndex.column] = temp
        updateBordersForCorrectPositions()
    }
    
    func isPuzzleCorrectlyPlaced(_ puzzle: SKSpriteNode) -> Bool {
        guard let puzzleName = puzzle.name else { return false }
        guard let index = indexOfPuzzle(puzzle) else { return false }
        let correctName = correctPuzzleArrangement[index.row * gridSize + index.column]
        return puzzleName == correctName
    }
    
    func indexOfPuzzle(_ puzzle: SKSpriteNode) -> (row: Int, column: Int)? {
        for row in 0..<gridSize {
            for column in 0..<gridSize {
                if puzzles[row][column] == puzzle {
                    return (row: row, column: column)
                }
            }
        }
        return nil
    }
    
    func updateScoreLabel() {
        scoreCountLabel.attributedText = NSAttributedString(string: "\(game!.score)/1000", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Unlock-Regular", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: UIColor(red: 122/255, green: 92/255, blue: 8/255, alpha: 1),
            NSAttributedString.Key.strokeWidth: -5
        ])
    }
}
