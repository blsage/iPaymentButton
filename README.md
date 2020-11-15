<h1 align="center"> iPaymentButton 💵 </p>
<h3 align="center"> Quickly implement & easily customize the Apple Pay button. 🤑</h3>
<p align="center">
    <strong><a href="#get-started">Get Started</a></strong> |
    <strong><a href="#examples">Examples</a></strong> |
    <strong><a href="#customize">Customize</a></strong> |
    <strong><a href="#install">Install</a></strong> | 
    <strong><a href="#usage">Usage</a></strong>
</p>
<p align="center">
    <img src="https://github.com/AlexFine/SwiftUICode/blob/master/public/assets/img/iPaymentButton-Demo-1.gif" alt="CI" width="70%"/>
</p>

<br/>

## Get Started

1. [Install](https://github.com/benjaminsage/iPaymentButton/blob/main/INSTALL.md) `iPages`

2. Add `iPaymentButton` to your project
```swift
import SwiftUI
import iPaymentButton

struct ContentView: View {
    var body: some View {
        iPaymentButton(action: {
            // Add your custom payment code here 
        })
    }
}
```

3. Customize your `iPages`


## Examples
### Starter
<img src="https://iswiftui.com/assets/img/iPaymentsButtonDemo1Dark.gif" width="200">

Use our built-in `applePayDemo()` to demo a purchase experience.

```swift
import SwiftUI
import iPaymentButton
import iGraphics

struct ContentView: View {
    var body: some View {
        iGraphicsBox().stack(3)

        iPaymentButton(action: {
            iPaymentButton.applePayDemo()
            // Add your custom payment code here 
        })
    }
}
```


### Modern
<img src="https://iswiftui.com/assets/img/iPaymentsButtonDemo2Light.gif" width="200">
Change the button type and style.

```swift
import SwiftUI
import iPaymentButton
import iGraphics

struct ContentView: View {
    var body: some View {
        iGraphicsView(.first)

        iPaymentButton(type: .support, style: .whiteOutline, action: {
            iPaymentButton.applePayDemo()
            // Add your custom payment code here 
        })
    }
}
```


## Customize
`iPaymentButton` has one required parameter: an action to execute on button tap. `iPaymentButton` supports several custom initializers and one custom modifier.

**Example**: Change the text, style and corner radius with the following code block:
```swift
iPaymentButton(type: .support, style: .whiteOutline, action: { } )
    .cornerRadius(25)
```

Use our exhaustive input list to customize your views.

Modifier or Initializer | Description
--- | ---
`type: PKPaymentButtonType = .buy` | The text written on the button. 🆒
`type: PKPaymentButtonStyle = .black` | The color that the button should be. 🎨
`action: @escaping () -> Void` | The action to be performed when the user taps the button. 🎬▶️
`.cornerRadius(radius: CGFloat) -> iPaymentButton` | Modifies the corner radius of the payment button ⬛️⚫️. To remove the rounded courners, set this value to 0.0 0️⃣👌. The default value is set to 4.0 🍀.


## Install 
Use the Swift package manager to install. Find instructions [here](https://github.com/benjaminsage/iPaymentButton/blob/main/INSTALL.md)😀


## Usage
<b>iPaymentButton is FREE and open-source for individuals, and will remain that way forever. </b>

iPaymentButton is distributed under a GNU GPL open-source license. 

Commercial users, please note, this license is often <b><a href="https://en.wikipedia.org/wiki/GNU_General_Public_License#Legal_barrier_to_app_stores">incompatible for many commercial applications</a></b>. If your app is distributed for commercial use, it could violate this open-source license even "if the application is free in the App Store". 

In order to offer iPaymentButton safely to our commercial friends we made it super easy to purchase a lifetime, full-use license for $9.99. Code on worry free 😁 

<p align="center"><a href="https://general099748.typeform.com/to/p5FtTKBj#package=iPaymentButton"> <img src="https://github.com/AlexFine/SwiftUICode/blob/master/public/assets/img/Purchase%20License.png" width="300"> </a> </p>

