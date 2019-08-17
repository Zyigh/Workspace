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
    static let setupDirs = [
        defaultDirForSetups,
        DbCommons.persistanceDirectory,
        //Language.templateDir
    ]
    
    static func invalidUrlFileHandler() {
        print("""
            It seems there is a problem with the setup folder '\(Setup.defaultDirForSetups)' needed to setup the project.
            Please report it as an issue at \(repoUrl) !
            """)
        exit(1)
    }

    private static func isDirInstalled(_ file: String) -> Bool {
        var isInstalled: Bool = true
        file.checkKindOfFile() {
            kind in

            switch kind {
            case .isDir:
                isInstalled = true
            case .isFile:
                isInstalled = false
            case .doesNotExist:
                isInstalled = false
            case .isNotAPath:
                //exit with error + message
                invalidUrlFileHandler()
            }
        }

        return isInstalled
    }

    public static func hasBeenInstalled() -> Bool {
        return setupDirs.reduce(into: true, { acc, dir in
            acc = acc && isDirInstalled(dir)
        })
    }
    
    public static func install() {
        print("Processing installation...")
        Setup.defaultDirForSetups.checkKindOfFile() {
            kind in
            
            switch kind {
            case .isDir :
                print("\(Setup.defaultDirForSetups) already exists")
            case .isFile :
                print("""
                    \(Setup.defaultDirForSetups) already exists but is a file.
                    Please rename it to setup project properly
                """)
                exit(2)
            case .doesNotExist :
                print("Creating \(Setup.defaultDirForSetups), default directory for setups")
                Setup.defaultDirForSetups.createDir()
            case .isNotAPath :
                invalidUrlFileHandler()
            }
        }
        DbCommons.installDefaultDir()
        print("Done !")
    }
    
    public static func checkIfInstalled() {
        if !Setup.hasBeenInstalled()
            || !DbCommons.hasBeenInstalled() {
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
