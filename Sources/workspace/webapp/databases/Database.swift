//
// Created by Hugo Medina on 2019-08-01.
//

import Foundation

class Database {
    let database: DatabaseStrategy

    public init(db: DatabaseStrategy) {
        database = db
    }
}
