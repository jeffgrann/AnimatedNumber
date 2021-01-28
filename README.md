# AnimatedNumber
A SwiftUI view that animates changes to a number by quickly counting up or down from the original value to the new value. Changes during animation, custom durations and formatting are supported.

![Output sample](https://successware.net/gifs/AnimatedNumber.gif)

**Simple Example**

```swift
import AnimatedNumber
import SwiftUI

struct ContentView: View {
    @State var value: Double = 0
    
    var body: some View {
        VStack {
            AnimatedNumber($value)
                .font(.largeTitle)
        }
    }
}
```

**Installation**

Requires iOS 14/MacOS 15 and Xcode 12.

In Xcode go to File -> Swift Packages -> Add Package Dependency and paste in the repo's url: https://github.com/jeffgrann/AnimatedNumber

**Full Example**

```swift
import AnimatedNumber
import SwiftUI

struct ContentView: View {
    @State var value: Double = 0
    
    let formatter = NumberFormatter()
    
    init() {
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .none
    }
    
    var body: some View {
        VStack {
            AnimatedNumber($value, duration: 1.5, formatter: formatter)
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            VStack(spacing: 20) {
                Button("Add 700") {
                    value += 700
                }
                
                Button("Remove 700") {
                    value -= 700
                }
            }
        }
    }
}
```
