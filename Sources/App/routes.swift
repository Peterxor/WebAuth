import Vapor
import Authentication

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("register", use: UserController().renderRegister)
    router.post("register", use: UserController().register)
    router.get("login", use: UserController().renderLogin)
    
    let authenticationRouter = router.grouped(User.authSessionsMiddleware())
    authenticationRouter.post("login", use: UserController().login)
    
    let protectorRouter = authenticationRouter.grouped(RedirectMiddleware<User>(path: "/login"))
    protectorRouter.get("profile", use: UserController().profile)
    
    router.get("logout", use: UserController().logout)
}
