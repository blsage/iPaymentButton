//
//  DemoApplePay.swift
//  DummyTest
//
//  Created by Kalil Fine on 10/5/20.
//

//
//  ApplePay.swift
//  ConsumerApp
//
//  Created by Benjamin Sage on 7/10/20.
//  Copyright © 2020 DeuceDrone. All rights reserved.
//

import UIKit
import PassKit
import SwiftUI
import iGraphics

public extension iPaymentButton {

    @available(iOS 13.0.0, *)
    struct DemoDonation: View {
        public var body: some View {
            VStack {
                CardsApp()
                iPaymentButton(type: .donate, style: .whiteOutline, action: {
                    applePayDemo()
                })
            }
        }
    }

    @available(iOS 13.0.0, *)
    struct DemoPrimary: View {
        public var body: some View {
            VStack {
                ShoppingApp()
                iPaymentButton(action: {
                    applePayDemo()
                })
            }
        }
    }


    @available(iOS 14.0.0, *)
    struct DemoGraphics: View {
        public var body: some View {
            VStack {
                MediaApp()
                iPaymentButton(type: .support, style: .whiteOutline, action: {
                    applePayDemo()
                })
            }
        }
    }


    @available(iOS 13.0.0, *)
    struct ShoppingApp: View {
        public var body: some View {
            iGraphicsBox()
                .stack(3)
        }
    }

    @available(iOS 13.0.0, *)
    struct CardsApp: View {
        public var body: some View {
            iGraphicsBox()
                .stack([.card, .caption])
        }
    }

    @available(iOS 13.0.0, *)
    struct MediaApp: View {
        public var body: some View {
            iGraphicsSwipeView(.first)
        }
    }


    @available(iOS 11.0, *)
    static func applePayDemo() {
        ExampleApplePayPopup().pay()
    }
}

public typealias PaymentCompletionHandler = (Bool) -> Void

@available(iOS 11.0, *)
public class ExampleApplePayPopup: NSObject {
    public override init() {}
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler!
    
    public static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .discover,
        .masterCard,
        .visa
    ]
    
    public class func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
    }
    
    private func demoCompletion(_: Bool) {}
    
//    public func startPayment(completion: @escaping PaymentCompletionHandler) {
    public func pay() {
        completionHandler = demoCompletion
        
        let subtotal = PKPaymentSummaryItem(label: "Subtotal", amount: 87.24, type: .final)
        let serviceFee = PKPaymentSummaryItem(label: "Service Fee", amount: 4.02, type: .final)
        let tax = PKPaymentSummaryItem(label: "Tax", amount: 8.04, type: .final)
        let total = PKPaymentSummaryItem(label: "Demo Corp", amount: 99.30, type: .final)
        paymentSummaryItems = [subtotal, serviceFee, tax, total]
        
        // Create our payment request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.demo"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.requiredShippingContactFields = [.postalAddress, .phoneNumber]
        paymentRequest.supportedNetworks = ExampleApplePayPopup.supportedNetworks
        
        // Display our payment request
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
//                debugPrint("Presented payment controller")
            } else {
//                debugPrint("Failed to present payment controller")
                self.completionHandler(false)
            }
        })
        
    }
}

/*
 PKPaymentAuthorizationControllerDelegate conformance.
 */
@available(iOS 11.0, *)
extension ExampleApplePayPopup: PKPaymentAuthorizationControllerDelegate {
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        // Perform some very basic validation on the provided contact information
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
//        if payment.shippingContact?.postalAddress?.isoCountryCode != "US" {
//            let pickupError = PKPaymentRequest.paymentShippingAddressUnserviceableError(withLocalizedDescription: "Sample App only picks up in the United States")
//            let countryError = PKPaymentRequest.paymentShippingAddressInvalidError(withKey: CNPostalAddressCountryKey, localizedDescription: "Invalid country")
//            errors.append(pickupError)
//            errors.append(countryError)
//            status = .failure
//        } else {
//            // Here you would send the payment token to your server or payment provider to process
//            // Once processed, return an appropriate status in the completion handler (success, failure, etc)
//        }
        
        self.paymentStatus = status
        print(payment)
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
        
        
    }
    
    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            print("payment controller did finish")
            // We are responsible for dismissing the payment sheet once it has finished
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
            }
            
        }
    }
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectPaymentMethod paymentMethod: PKPaymentMethod, handler completion: @escaping (PKPaymentRequestPaymentMethodUpdate) -> Void) {
        // The didSelectPaymentMethod delegate method allows you to make changes when the user updates their payment card
        // Here we're applying a $2 discount when a debit card is selected
        guard paymentMethod.type == .debit else {
            completion(PKPaymentRequestPaymentMethodUpdate(paymentSummaryItems: paymentSummaryItems))
            return
        }
        print("hi")
        
//        var discountedSummaryItems = paymentSummaryItems
//        let discount = PKPaymentSummaryItem(label: "Debit Card Discount", amount: NSDecimalNumber(string: "-2.00"))
//        discountedSummaryItems.insert(discount, at: paymentSummaryItems.count - 1)
//        if let total = paymentSummaryItems.last {
//            total.amount = total.amount.subtracting(NSDecimalNumber(string: "2.00"))
//        }
//        completion(PKPaymentRequestPaymentMethodUpdate(paymentSummaryItems: discountedSummaryItems))
    }
}
