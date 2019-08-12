//
// Created by Hugo Medina on 2019-03-20.
//

import Foundation
import Stencil

// The files Tree for the project which is created
struct Tree {
    typealias File = (name: String, content: String?)
    typealias Directory = (dirname: String, tree: Tree)

    let files: [File]
    let children: [Directory]

    init(files: [File], children: [Directory]? = nil) {
        self.files = files
        self.children = children ?? []
    }
}

// Class that handle the Language used using a Language Strategy design pattern for specific language
class Language {
    // The language for which the Dockerfile and tree will be created
    let language: LanguageStrategy
    // Stencil prerequisit
    let environment : Environment
    var tree : Tree {
        get {
            return language.tree
        }
    }

    // Set the language and the Environment for Stencil
    init(_ l: LanguageStrategy) {
        language = l
        let fsLoader = FileSystemLoader(paths: ["templates/"])
        environment = Environment(loader: fsLoader)
    }

    // Useless method to check that the basic is working
    public func test() {
        return language.test()
    }

    // @Todo put the Dockerfile at his destination in the tree created
    public func putDockerfileAtDestination(_ dockerfile: String) {
        print(dockerfile)
    }

    // Create Dockerfile from language. Get an error if the language is not implemented
    public func writeDockerfile() {
        let context = language.generateDockerfileContext()
        if context.count < 1 {
            if let l = language as? NotAvailableLanguage {
                l.notImplementedError()
            } else {
                print("Error occurred, please don't do that again...")
                exit(1)
            }
        }

        do {
            let dockerfile = try environment.renderTemplate(name: "template.Dockerfile", context: context)
            putDockerfileAtDestination(dockerfile)
        } catch let e {
            print(e.localizedDescription)
        }
    }

    public func createFiles(_ tree: Tree, from startPoint: String) {
        for file in tree.files {
            let newFilename = (startPoint + file.name).expand
            newFilename.checkKindOfFile() { kind in
                switch kind {
                case .isNotAPath:
                    print("\(newFilename) is not a valid path")
                    exit(2)
                case .isFile:
                    print("\(newFilename) already exists")
                default:
                    FileManager.default.createFile(atPath: startPoint + file.name, contents: file.content?.data(using: .utf8))
                }
            }
        }

        for child in tree.children {
            let newDirname = (startPoint + child.dirname).expand
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

                self.createFiles(child.tree, from: newDirname)
            }
        }
    }
}
