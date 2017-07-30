# LigthDI
Light Dependency Injection Container

##### Example:
```swift
let factory = AssemblyFactory()
let container = DependencyContainer(assemblyFactory: factory)

container.applay(SomeModuleAssembly.self)
container.applay(SomeServiceAssembly.self)

let result = container.resolveModule(SomeModuleAssembly.self).module()
print(result)
```
