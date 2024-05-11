# AdWizard iOS SDK 🧙🏻‍♂️

## Overview 💡

The AdWizard iOS SDK is a simple tool that you can use to send events from your app directly to AdWizard's server. The AdWizard SDK has a public class `AdWizard`that is a singleton with two public methods, one for configuration and another for sending events, for more details see documentation below.

## Configuration ⚙️

On your application's start import the AdWizard library and call the method configure to pass your api key. Don't have a api key yet? Download the adWizard app on the mac appStore, register and get your app api key by clicking the profile button on the top right of the window.

```
import AdWizard

AdWizard.shared.configure(apiKey: "YOUR_API_KEY")
```

## Send events 📬

AdWizard SDK automatically sends a `download` event when you call the `configure` method if its needed, so don't worry about the download events, we take care of everything. If you want to send custom events like a purchase or login event for example you can use the `sendEvent` method and pass the name of the event that you want to send.

```
import AdWizard

AdWizard.shared.sendEvent(eventName: "YOUR_EVENT_NAME")
```
