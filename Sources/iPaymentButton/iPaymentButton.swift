import UIKit
import PassKit
import SwiftUI

@available(iOS 13.0, *)
/// A payment button wrapper view around Apple's PassKit `PKPaymentButton`
/// which allows the button to be drawn and rendered complely using SwiftUI
public struct iPaymentButton: View {
    
    private var type: PKPaymentButtonType
    private var style: PKPaymentButtonStyle
    private var action: () -> Void
    
    /// Creates a new payment button
    /// - Parameters:
    ///   - type: The text written on the button
    ///   - style: The color that the button should be
    ///   - action: The action to be performed when the user taps the button
    public init(action: @escaping () -> Void,
                type: PKPaymentButtonType = .buy,
                style: PKPaymentButtonStyle = .black
                )
    {
        self.type = type
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()
            ExampleApplePayPopup().pay()
        }, label: { EmptyView() } )
            .buttonStyle(iPaymentButtonStyle(type: type, style: style))
    }
}

@available(iOS 13.0.0, *)
fileprivate struct iPaymentButtonStyle: ButtonStyle {
    var type: PKPaymentButtonType
    var style: PKPaymentButtonStyle
    func makeBody(configuration: Self.Configuration) -> some View {
        return iPaymentButtonHelper(type: type, style: style)
    }
}

@available(iOS 13.0.0, *)
fileprivate struct iPaymentButtonHelper: View {
    var type: PKPaymentButtonType
    var style: PKPaymentButtonStyle
    var body: some View {
        iPaymentButtonRepresentable(type: type, style: style)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
    }
}

@available(iOS 13.0.0, *)
extension iPaymentButtonHelper {
    struct iPaymentButtonRepresentable: UIViewRepresentable {
        var type: PKPaymentButtonType
        var style: PKPaymentButtonStyle
        func makeUIView(context: Context) -> PKPaymentButton {
            PKPaymentButton(paymentButtonType: type, paymentButtonStyle: style)
        }
        func updateUIView(_ uiView: PKPaymentButton, context: Context) { }
    }
}
