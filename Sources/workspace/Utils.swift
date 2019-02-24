//
//  Utils.swift
//  workspace
//
//  Created by Hugo Medina on 24/02/2019.
//

import Foundation
import Guaka

let repoUrl = "https://github.com/Zyigh/Workspace"

protocol CommandSetup {
    static func getCommand() -> Command
    static func getSetupFlags() -> [Flag]
}

// File and Dirs manager
enum KindOfFile {
    case isDir
    case isFile
    case doesNotExist
    case isNotAPath
}

extension String {
    func createDir() {
        do {
            try FileManager.default.createDirectory(atPath: self, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
    }
    
    var expand:String { return NSString(string: self).expandingTildeInPath }
    
    func checkKindOfFile(completion: @escaping (KindOfFile)->Void) {
        guard nil != URL(string: self) else {
            completion(.isNotAPath)
            return
        }
        var isDir : ObjCBool = false
        let completionArg: KindOfFile
        if FileManager.default.fileExists(atPath: self, isDirectory: &isDir) {
            if isDir.boolValue {
                completionArg = .isDir
            }
            else {
                completionArg = .isFile
            }
        }
        else {
            completionArg = .doesNotExist
        }
        
        completion(completionArg)
    }
}
