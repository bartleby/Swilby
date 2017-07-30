# LigthDI
Light Dependency Injection Container

##### Example:
```swift
class SomeModuleAssembly: ModuleAssembly {
    func module() -> String {
        return "SomeModule with service: \(self.container.resolveService(SomeServiceAssembly.self).service())"
    }
}
```
```swift
class SomeServiceAssembly: ServiceAssembly {
    func service() -> String {
        return "SomeService"
    }
}

```

```swift
let factory = AssemblyFactory()
let container = DependencyContainer(assemblyFactory: factory)

container.applay(SomeModuleAssembly.self)
container.applay(SomeServiceAssembly.self)

let result = container.resolveModule(SomeModuleAssembly.self).module()
print(result)
```
