import Vapor
import FluentSQLite
import Authentication

final class User: SQLiteModel{
    var id: Int?
    var useremail: String
    var password: String
    
    init(id: Int? = nil, useremail: String, password: String) {
        self.id = id
        self.useremail = useremail
        self.password = password
    }
}

extension User: Migration{}
extension User: Content{}
extension User: PasswordAuthenticatable{
    static var usernameKey: WritableKeyPath<User, String> {
        return \User.useremail
    }
    static var passwordKey: WritableKeyPath<User, String> {
        return \User.password
    }
}

extension User: SessionAuthenticatable{}
