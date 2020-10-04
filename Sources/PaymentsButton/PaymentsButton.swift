import UIKit
import PassKit
import SwiftUI

@available(iOS 13.0, *)
public struct PaymentButton: View {
    var action: () -> Void
    var type: PKPaymentButtonType = .buy
    var style: PKPaymentButtonStyle = .black
    
    public var body: some View {
        Button(action: action, label: { EmptyView() } )
            .buttonStyle(PaymentButtonStyle(type: type, style: style))
    }
}

@available(iOS 13.0.0, *)
fileprivate struct PaymentButtonStyle: ButtonStyle {
    var type: PKPaymentButtonType
    var style: PKPaymentButtonStyle
    func makeBody(configuration: Self.Configuration) -> some View {
        return PaymentButtonHelper(type: type, style: style)
    }
}

@available(iOS 13.0.0, *)
fileprivate struct PaymentButtonHelper: View {
    var type: PKPaymentButtonType
    var style: PKPaymentButtonStyle
    var body: some View {
        PaymentButtonRepresentable(type: type, style: style)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
    }
}

@available(iOS 13.0.0, *)
extension PaymentButtonHelper {
    struct PaymentButtonRepresentable: UIViewRepresentable {
        var type: PKPaymentButtonType
        var style: PKPaymentButtonStyle
        func makeUIView(context: Context) -> PKPaymentButton {
            PKPaymentButton(paymentButtonType: type, paymentButtonStyle: style)
        }
        func updateUIView(_ uiView: PKPaymentButton, context: Context) { }
    }
}
