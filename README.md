
# SolaceSphere - Weather App

SolaceSphere is a simple weather app that allows you to check the current weather in different cities. You can enter a city name, and it will provide you with the temperature, conditions, and additional weather information.

(sc<img width="356" alt="Screenshot 2023-10-23 at 12 26 36 AM" src="https://github.com/PRATIKK0709/SoloSphere/assets/139443204/a41b4858-87df-4aa0-b038-dda5cbd4c424">
reenshot.png)

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

## API Key

This project uses the Weatherstack API for weather data. You need to sign up for an API key at [Weatherstack](https://weatherstack.com/). Once you have your API key, replace `"YOUR_API_KEY"` with your actual key in the `ContentView.swift` file.

```swift
let apiKey = "YOUR_API_KEY"
