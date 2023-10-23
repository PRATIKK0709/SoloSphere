
# SolaceSphere - Weather App

SolaceSphere is a simple weather app that allows you to check the current weather in different cities. You can enter a city name, and it will provide you with the temperature, conditions, and additional weather information.

<img src="https://cdn.discordapp.com/attachments/929653900812886076/1165973129634525184/simulator_screenshot_AA4F1953-0F9D-413F-AC18-6C9A5B513223.png?ex=6548cc18&is=65365718&hm=69b46de2428d4edabe77cffcbad62efcfc7fb9a181a7c96f7fe09f43679ac26d&" width="100" height="216.79" alt="ss">





## Features

- Check the current temperature in any city
- Get information on conditions, wind speed, UV index, and more
- Beautiful UI with dynamic background based on temperature
- Easy to use and user-friendly

## Technologies Used

- SwiftUI
- Swift Programming Language
- Weatherstack API

## Getting Started

To get started with this project, follow these steps:

1. Clone this repository to your local machine.
2. Open the project using Xcode.
3. Build and run the project on the iOS Simulator or a physical device.
4. Enter the name of the city for which you want to check the weather.
5. Click the "Check Weather" button to get the current weather details.
- won't really suggest you to clone tho, as this is my personal project, let it be unique!
## API Key

This project uses the Weatherstack API for weather data. You need to sign up for an API key at [Weatherstack](https://weatherstack.com/). Once you have your API key, replace `"YOUR_API_KEY"` with your actual key in the `ContentView.swift` file.

```swift
let apiKey = "YOUR_API_KEY"
