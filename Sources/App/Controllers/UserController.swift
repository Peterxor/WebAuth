import Vapor
import FluentSQLite
import Crypto

final class UserController{
    func renderRegister(req: Request) throws -> Future<View>{
        return try req.view().render("register")
    }
    
    func register(req: Request) throws -> Future<Response>{
        return try req.content.decode(User.self).flatMap({ user in
            return User.query(on: req).filter(\User.email == user.email).first().flatMap({ result in
                if let _ = result{
                    return Future.map(on: req, { () in
                        return req.redirect(to: "/register")
                    })
                }
                user.password = try BCryptDigest().hash(user.password)
                return user.save(on: req).map({ (_) in
                    return req.redirect(to: "/login")
                })
            })
        })
    }
    
    func renderLogin(req: Request) throws -> Future<View>{
        return try req.view().render("login")
    }
    
    func login(req: Request) throws -> Future<Response>{
        return try req.content.decode(User.self).flatMap({ user in
            return User.authenticate(username: user.email, password: user.password, using: BCryptDigest(), on: req).map({ user in
                guard let user = user else{
                    return req.redirect(to: "/login")
                }
                try req.authenticateSession(user)
                return req.redirect(to: "/profile")
            })
        })
    }
    
    func profile(req: Request) throws -> Future<View>{
        let user = try req.requireAuthenticated(User.self)
        let data = ["user": user]
        return try req.view().render("profile", data)
    }
}
