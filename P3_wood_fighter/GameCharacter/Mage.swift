import Foundation
class Mage: Character {
    override init() {
        super.init()
        health = 50
        currentHealth = 50
        type = GameCharacter.Mage
        custom = "👨‍🔬"
        weapon = Scepter(healing: 50)
        
    }
    
    
}
