//
//  Setup.swift
//  workspace
//
//  Created by Hugo Medina on 23/02/2019.
//

import Foundation
import Guaka

class Setup {
    static let defaultDirForSetups = "~/.zwsp".expand
    
    public static func hasBeenInstalled() -> Bool {
        var isInstalled = false
        defaultDirForSetups.checkKindOfFile() {
            kind in
            
            switch kind {
            case .isDir:
                isInstalled = true
            case .isFile:
                isInstalled = false
            case .doesNotExist:
                isInstalled = false
            case .isNotAPath:
                print("Problem with base setup directory : It doesn't seem to be a valid path")
                exit(1)
            }
        }
        
        return isInstalled
    }
    
    public static func install() {
        print("Processing installation")
    }
    
    public static func checkIfInstalled() {
        if !Setup.hasBeenInstalled() {
            print("""
        Workspace seems to not be installed. You can easily install it by running :
        workspace setup
    """)
            exit(1)
        }
    }
}

extension Setup: CommandSetup {
    static func getCommand() -> Command {
        return Command(usage: "setup") {
            _, _ in
            
            Setup.install()
        }
    }
    
    // Not usefull for now, only one setup is available
    static func getSetupFlags() -> [Flag] {
        return []
    }
}
