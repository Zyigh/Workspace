//
//  Utils.swift
//  workspace
//
//  Created by Hugo Medina on 24/02/2019.
//

import Foundation

let repoUrl = "https://github.com/Zyigh/Workspace"

// File and Dirs manager
enum KindOfFile {
    case isDir
    case isFile
    case doesNotExist
    case isNotAPath
}

// The files Tree for the project which is created
struct Tree {
    typealias File = (name: String, content: String?)
    typealias Directory = (dirname: String, tree: Tree)

    var files: [File]
    let children: [Directory]

    init(files: [File], children: [Directory]? = nil) {
        self.files = files
        self.children = children ?? []
    }

    public func createFiles(from startPoint: String) {
        for file in self.files {
            let newFilename = (startPoint + file.name).expand
            newFilename.checkKindOfFile() { kind in
                switch kind {
                case .isNotAPath:
                    print("\(newFilename) is not a valid path")
                    exit(2)
                case .isFile:
                    print("\(newFilename) already exists")
                default:
                    FileManager.default.createFile(atPath: startPoint + "/" + file.name, contents: file.content?.data(using: .utf8))
                }
            }
        }

        for child in self.children {
            let newDirname = (startPoint + "/" + child.dirname).expand
            newDirname.checkKindOfFile() { kind in
                switch kind {
                case .isNotAPath:
                    print("\(newDirname) is not a valid path")
                    exit(2)
                case .doesNotExist:
                    newDirname.createDir()
                default:
                    print("\(newDirname) already exists")
                }

                child.tree.createFiles(from: newDirname)
            }
        }
    }
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

extension FileManager {
    public func copy(_ itemUrl: URL, at destination: URL) -> Bool {
        do {
            let fm = FileManager.default
            if fm.fileExists(atPath: String(describing: destination)) {
                try fm.removeItem(at: destination)
            }
            try fm.copyItem(at: itemUrl, to: destination)
        } catch (let err) {
            print("Cannot copy item at \(itemUrl) to \(destination): \(err)")

            return false
        }

        return true
    }

    public func copy(_ itemUrl: String, at destination: String) -> Bool {
        guard let src = URL(string: itemUrl) else {
            print("\(itemUrl) is not a valid URL")
            return false
        }

        guard let dest = URL(string: destination) else {
            print("\(destination) is not a valid URL")
            return false
        }

        return copy(src, at: dest)
    }
}
