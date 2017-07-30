# LigthDI
Light Dependency Injection Container

## Example:
```swift
class SomeModuleAssembly: ModuleAssembly {
    func module() -> String {
        let service = self.container.resolveService(SomeServiceAssembly.self).service()
        return "SomeModule with service: \(service)"
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

##### Weak Box

```swift
class SomeServiceAssembly: ServiceAssembly {
    func service() -> String {
        return weakBox {
            return "SomeService"
        }
    }
}
```
```swift
// create new SomeService
let someService = self.container.resolveService(SomeServiceAssembly.self).service()

// make link to someService, like someService2 = someService
let someService2 = self.container.resolveService(SomeServiceAssembly.self).service()

someService = nil // SomeService hasn't been released
someService2 = nil // SomeService has been released
```

##### Strong Box (like singleton)

```swift
class SomeServiceAssembly: ServiceAssembly {
    func service() -> String {
        return strongBox {
            return "SomeService"
        }
    }
}

```
```swift
// create new SomeService singleton
let someService = self.container.resolveService(SomeServiceAssembly.self).service()

// make link to someService, like someService2 = someService
let someService2 = self.container.resolveService(SomeServiceAssembly.self).service()

someService = nil // SomeService hasn't been released
someService2 = nil // SomeService hasn't been released becouse it is have behavior like singleton now

// link to SomeService singleton
let someService = self.container.resolveService(SomeServiceAssembly.self).service()

```
