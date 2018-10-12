import Foundation
class Message {
    static func welcome() {
        print("                           -----------------------------")
        print("                           🔱 Welcome to Wood Fighter 🔱")
        print("                           -----------------------------")
        print()
        print("Deux joueurs vont s'affronter. Joueur 1 et joueur 2. ")
        print("Code couleur du jeu :")
        print("🔷 Joueur attaquant  🔷")
        print("🔶 Joueur en défense 🔶")
        print()
        print("Chaque joueur va constituer son équipe en choisissant parmis ces 4 types de personnages :")
        print()
        print("\(Fighter.init().custom) = un bon guerrier !.......................➡️ [HP: \(Fighter.init().health) - ARME: \(Fighter.init().weapon.name) - ACTION: \(Fighter.init().weapon.damage) pts]")
        print("\(Mage.init().custom) = il soigne les membres de son équipe.")
        print("     il ne peut pas se soigner lui même......➡️ [HP: \(Mage.init().health) - ARME: \(Mage.init().weapon.name) - ACTION: \(Mage.init().weapon.healing) pts]")
        print("\(Colossus.init().custom) = il inflige beaucoup de dégâts...........➡️ [HP: \(Colossus.init().health) - ARME: \(Colossus.init().weapon.name) - ACTION: \(Colossus.init().weapon.damage) pts]")
        print("\(Dwarf.init().custom) = petit mais costaud......................➡️ [HP: \(Dwarf.init().health) - ARME: \(Dwarf.init().weapon.name) - ACTION: \(Dwarf.init().weapon.damage) pts]")
        print()
        print(SEPARATOR_SCALE)
        print()
    }
    static func teamBuildingTitle()  {
        print("                           -----------------------------")
        print("                           🔱 Constituez votre équipe 🔱")
        print("                           -----------------------------")
    }
    static func teamDescription()  {
        print("                           -----------------------")
        print("                           🔱 Voici les équipes 🔱")
        print("                           -----------------------")
    }
    static func startToFight()  {
        print("                         --------------------------")
        print("                         🔱 LET'S START TO FIGHT 🔱")
        print("                         --------------------------")
    }
    static func treasure()  {
        print("                        -------------------------------")
        print("                        🔷⚱️ IL A TROUVÉ UN COFFRE ⚱️🔷")
        print("                        -------------------------------")
    }
    static func congratulations()  {
        print("                             ---------------------")
        print("                             🏆 CONGRATULATIONS 🏆")
        print("                             ---------------------")
    }

    static func goodBye() {
        print()
        print("🔱 À bientôt 💤")
        print()
    }
}
