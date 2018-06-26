import Vapor
import Leaf
import FluentSQLite
/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    try services.register(FluentSQLiteProvider())
    var databases = DatabasesConfig()
    databases.add(database: try SQLiteDatabase(storage: .memory), as: .sqlite)
    services.register(databases)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    services.register(migrations)
}

