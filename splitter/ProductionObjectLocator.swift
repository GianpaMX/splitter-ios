final class ProductionObjectLocator: ObjectLocator {
    private lazy var objects: Dictionary<String, Any> = [:]

    private func typeName(some: Any) -> String {
        return (some is Any.Type) ?
        "\(some)": "\(type(of: some))"
    }

    func addObject<T>(object: T) {
        let key = typeName(some: object)
        objects[key] = object
    }

    func addObject<T>(object: T, t : Any.Type) {
        let key = typeName(some: t)
        objects[key] = object
    }

    func getObject<T>() -> T? {
        let key = typeName(some: T.self)
        return objects[key] as? T
    }
}
