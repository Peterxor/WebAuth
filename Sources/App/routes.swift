import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("register", use: UserController().renderRegister)
    router.post("register", use: UserController().register)
}
