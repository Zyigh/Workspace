import Foundation
import Guaka

let workspace = Command(usage: "workspace") {
    flags, args in
    
    Setup.checkIfInstalled()
}

workspace.add(subCommand: Webapp.getCommand())
workspace.add(subCommand: Setup.getCommand())

workspace.execute()
