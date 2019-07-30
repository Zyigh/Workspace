//
// Created by Hugo Medina on 2019-07-28.
//

import Foundation

struct LanguageContext : Context {
    let hasWorkdir: Bool
    let steps: [String]
    let language: String
    let cmd: String?

    public func toStringAny() -> [String: Any] {
        var stringAnyzed: [String: Any] = [
            "hasWorkdir": hasWorkdir,
            "steps": steps,
            "language": language
        ]

        if let cmd = cmd {
            stringAnyzed["cmd"] = cmd
        }

        return stringAnyzed
    }
}
