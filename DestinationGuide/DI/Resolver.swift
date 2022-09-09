import Swinject

class Resolver {
    static let shared = Resolver()
    private let assembler = Assembler([
        DestinationAssembly(),
        DestinationDetailsAssembly()
    ])
    // get the IOC container
    private var resolver: Swinject.Resolver

    init() {
        resolver = assembler.resolver
    }

    func resolve<T>(_: T.Type) -> T {
        resolver.resolve(T.self)!
    }
}
