# Favorite Event

iPhone app in Swift that presents one view controller containing a table view that shows a list of events. The cells of the list should display information about an event as follows. Update Event state (Favorite & Unfavorite)

<p align="center">
  <img width=35% src="https://github.com/AjayOdedara/FavoriteApp/blob/main/eventPage.png" />
</p>

## Table of Contents

- [About](#about)
- [Quick Start](#quick-start)
- [Features](#features)

## About

This mobile application is built using Swift 5.0 and Xcode 11.0 for iOS devices running iOS 13.0.

If attempting to run this code on future versions of Swift, Xcode, or iOS some additional work may be required to get this code running smoothly.

## Quick Start

The following steps will guide you through the process of running this application on your local machine, and device.

1. Ensure you have [Xcode 11.0](https://developer.apple.com/download/) installed
2. Ensure you have [SwiftLint](https://github.com/realm/SwiftLint) installed ( to opt out remove it from Target > Build Phases > SwiftLint )
3. Checkout this repository
4. Open `FavoriteApp.xcodeproj` with Xcode
5. Go to the project settings, and change the code signing team to your own
6. Wait for the Swift Packages to download if not.

Code signing settings are left at automatic here for simplicity, you can set these to manual if needed but these steps will not take you through that process.

6. Attach an iPhone running iOS 13.0
7. Ensure the iPhone has development mode enabled, from the Devices & Simulators window: <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>2</kbd>
8. Clean, build and run the application on an iPhone running iOS 13.0

## Features

Below is the set of user stories that outline the intended functionality of this mobile application.

### User Stories
- Update Event state (Favorite & Unfavorite)
- Show offline data with latest fetched events when Internet isn't available 
- A scalable implementation of pagination
- Clean code(with MVVM) & UI 
- Network Layer & Parsing
- Unit Tests
- Localizations
- Dark Mode Support
