import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("register", use: UserController().renderRegister)
    router.post("register", use: UserController().register)
    router.get("login", use: UserController().renderLogin)
    router.post("login", use: UserController().login)
    router.get("success") { req -> String in
        return "success"
    }
    router.get("wrongpassword") { req -> String in
        return "wrong password"
    }
}
