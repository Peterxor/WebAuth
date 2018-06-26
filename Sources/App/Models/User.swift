import Vapor
import FluentSQLite

final class User: SQLiteModel{
    var id: Int?
    var username: String
    
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
}

extension User: Migration{}
extension User: Content{}
