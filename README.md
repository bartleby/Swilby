# LigthDI
Light Dependency Injection Container

## Example:
```swift
class SomeModuleAssembly: Assembly {
    func build() -> String {
        let service = container.resolve(SomeServiceAssembly.self).build()
        return "SomeModule with service: \(service)"
    }
}
```
```swift
class SomeServiceAssembly: Assembly {
    func build() -> String {
        return "Some Service"
    }
}

```

```swift
let factory: AssemblyFactoryProtocol = AssemblyFactory()
let container: LightContainer = DependencyContainer(assemblyFactory: factory)
        
container.apply(SomeModuleAssembly.self)
container.apply(SomeServiceAssembly.self)
        
let result = container.resolve(SomeModuleAssembly.self).build()
print(result)
```

##### Weak Box

```swift
class SomeServiceAssembly: Assembly {
    func build() -> String {
        return weakBox {
            return "Some Service"
        }
    }
}
```
```swift
// create new SomeService
let someService = container.resolve(SomeServiceAssembly.self).build()

// make link to someService, like someService2 = someService
let someService2 = container.resolve(SomeServiceAssembly.self).build()

someService = nil // SomeService hasn't been released
someService2 = nil // SomeService has been released
```

##### Strong Box (like singleton)

```swift
class SomeServiceAssembly: Assembly {
    func build() -> String {
        return strongBox {
            return "Some Service"
        }
    }
}
```
```swift
// create new SomeService singleton
let someService = container.resolve(SomeServiceAssembly.self).build()

// make link to someService, like someService2 = someService
let someService2 = container.resolve(SomeServiceAssembly.self).build()

someService = nil // SomeService hasn't been released
someService2 = nil // SomeService hasn't been released becouse it behaves like Singleton now

// link to SomeService singleton
let someService = container.resolve(SomeServiceAssembly.self).build()

```
