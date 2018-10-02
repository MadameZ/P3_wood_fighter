import Foundation
class Message {
    static func welcome() {
        print("🔱 Welcome to Wood Fighter 🔱")
        print()
        print("Chaque joueur va constituer son équipe en choisissant parmis ces 4 types de personnages.")
        print()
        print("\(Fighter.init().custom) : un bon guerrier !.......................👉🏽 [ HP:\(Fighter.init().health) - Arme:\(Fighter.init().weapon!.name) - Action:\(Fighter.init().weapon!.damage) pts ]")
        print("\(Mage.init().custom) : il prend soin de son équipe.............👉🏽 [ HP:\(Mage.init().health) - Arme:\(Mage.init().weapon!.name) - Action:\(Mage.init().weapon!.healing) pts ]")
        print("     il ne peut pas se soigner lui même.")
        print("\(Colossus.init().custom) : il inflige beaucoup de dégât............👉🏽 [ HP:\(Colossus.init().health) - Arme:\(Colossus.init().weapon!.name) - Action:\(Colossus.init().weapon!.damage) pts ]")
        print("\(Dwarf.init().custom) : petit mais costaud......................👉🏽 [ HP:\(Dwarf.init().health) - Arme:\(Colossus.init().weapon!.name) - Action:\(Dwarf.init().weapon!.damage) pts ]")
        print()
        print(SEPARATOR_SCALE)
        print()
    }
    static func goodBye() {
        print("À bientôt 💤")
    }
}
