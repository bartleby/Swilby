# Swilby
A light-weight Dependency Injection Container on based Assembly

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
print(result) // SomeModule with service: Some Service
```

### Weak Box

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

someService = nil // SomeService will not be released
someService2 = nil // SomeService will now be released
```

### Strong Box (like singleton)

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
// create new SomeService
let someService = container.resolve(SomeServiceAssembly.self).build()

// make link to someService, like someService2 = someService
let someService2 = container.resolve(SomeServiceAssembly.self).build()

someService = nil // SomeService will not be released
someService2 = nil // SomeService will still not be released because it is singelton

// you can get a link to a instanse of singelton
let someService = container.resolve(SomeServiceAssembly.self).build()

```
