//
//  DbCommons.swift
//  workspace
//
//  Created by Hugo Medina on 24/02/2019.
//

import Foundation

class DbCommons {
    static let persistanceDirectory = Setup.defaultDirForSetups + "/databases"
    
    static func installDefaultDir() {
        persistanceDirectory.checkKindOfFile() {
            kind in
            
            switch kind {
            case .isDir :
                print("\(persistanceDirectory) already exists")
            case .isFile :
                print("""
                    \(persistanceDirectory) already exists but is a file.
                    Please rename it to setup project properly
                    """)
                exit(2)
            case .doesNotExist :
                print("Creating \(persistanceDirectory), to save databases")
                persistanceDirectory.createDir()
            case .isNotAPath :
                print("""
                    It seems there is a problem with the setup folder '\(persistanceDirectory)' needed to setup the project.
                    Please report it as an issue at \(repoUrl) !
                    """)
                exit(1)
            }
        }
    }
}
