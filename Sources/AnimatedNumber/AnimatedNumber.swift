//  See: https://swiftui.diegolavalle.com/posts/pausing-reversing-animations/

import SwiftUI

//---------------------------------------------------------------------------------
// AnimatedNumber
//---------------------------------------------------------------------------------
@available(iOS 14.0, OSX 11.0, *)
public struct AnimatedNumber: View {
    @State private var destinationValue: Double
    private let duration: Double
    private let formatter: Formatter
    @State private var originalValue: Double
    @State private var percentage = Double(0)
    @Binding private var value: Double
    
    public init(_ value: Binding<Double>, duration: Double = 0.7, formatter: Formatter = NumberFormatter()) {
        _value = value
        _originalValue = .init(initialValue: value.wrappedValue)
        _destinationValue = .init(initialValue: value.wrappedValue)
        self.duration = duration
        self.formatter = formatter
    }
    
    public var body: some View {
        EmptyView()
            .modifier(
                AnimatedNumberModifier(
                    value: $value,
                    originalValue: $originalValue,
                    destinationValue: $destinationValue,
                    duration: duration,
                    percentage: $percentage,
                    formatter: formatter
                )
            )
    }
}

//---------------------------------------------------------------------------------
// AnimatedNumberModifier
//---------------------------------------------------------------------------------
@available(iOS 14.0, OSX 11.0, *)
//@available(OSX 11.0, unavailable)
fileprivate struct AnimatedNumberModifier: AnimatableModifier {
    private var animationPercentage: Double
    @Binding private var destinationValue: Double
    private let formatter: Formatter
    @Binding private var originalValue: Double
    @Binding private var percentage: Double
    private var duration: Double
    @Binding private var value: Double
    
    init(value: Binding<Double>, originalValue: Binding<Double>, destinationValue: Binding<Double>, duration: Double, percentage: Binding<Double>, formatter: Formatter) {
        _value = value
        _originalValue = originalValue
        _destinationValue = destinationValue
        self.duration = duration
        _percentage = percentage
        animationPercentage = percentage.wrappedValue
        self.formatter = formatter
    }
    
    var animatableData: Double {
        get { animationPercentage }
        set { animationPercentage = newValue }
    }
    
    private var animatedValue: Double {
        originalValue + ((destinationValue - originalValue) * animationPercentage)
    }
    
    func body(content: Content) -> some View {
        if animationPercentage == 1 {
            DispatchQueue.main.async {
                percentage = 0
                originalValue = value
                destinationValue = value
            }
        }
        
        return
            Text(displayValue)
            .onChange(of: value) { _ in
                if isAnimating {
                    // Restart the animation from the current value to the destination value.
                    withAnimation(.linear(duration: 0)) {
                        percentage = 0
                    }
                    
                    DispatchQueue.main.async {
                        originalValue = animatedValue
                        destinationValue = value

                        withAnimation(.linear(duration: duration)) {
                            percentage = 1
                        }
                    }
                } else {
                    destinationValue = value
                    
                    withAnimation(.linear(duration: duration)) {
                        percentage = 1
                    }
                }
            }
    }
    
    private var displayValue: String {
        formatter.string(for: animatedValue as NSNumber)!
    }
    
    private var isAnimating: Bool {
        percentage != 0
    }
}
