import Vapor


final class UserController{
    func renderRegister(req: Request) throws -> Future<View>{
        return try req.view().render("register")
    }
}
