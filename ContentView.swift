import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var city = ""
    @State private var weatherData: WeatherData?
    @State private var isFetchingData = false

    let apiKey = "your api key"

    struct WeatherData: Codable {
        var location: Location
        var current: Current

        struct Location: Codable {
            var name: String
            var country: String
            var region: String
            var lat: String
            var lon: String
            var timezone_id: String
            var localtime: String
            var localtime_epoch: Int
            var utc_offset: String
        }

        struct Current: Codable {
            var observation_time: String
            var temperature: Int
            var weather_code: Int
            var weather_icons: [String]
            var weather_descriptions: [String]
            var wind_speed: Int
            var wind_degree: Int
            var wind_dir: String
            var pressure: Int
            var precip: Int
            var humidity: Int
            var cloudcover: Int
            var feelslike: Int
            var uv_index: Int
            var visibility: Int
            var is_day: String
        }
    }

    struct GlassButton: View {
        var label: String
        var action: () -> Void

        var body: some View {
            Button(action: action) {
                Text(label)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(BlurView(style: .systemThinMaterial))
                    .cornerRadius(10)
                    .opacity(0.8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
        }
    }

    struct BlurView: UIViewRepresentable {
        let style: UIBlurEffect.Style

        func makeUIView(context: Context) -> UIVisualEffectView {
            let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
            return view
        }

        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                backgroundForTemperature(weatherData?.current.temperature)

                ScrollView {
                    VStack(alignment: .center, spacing: 20) { // Center alignment
                        Text("SolaceSphere")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()

                        TextField("Enter City", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .disabled(isFetchingData)

                        if let temperature = weatherData?.current.temperature {
                            WeatherRow(title: "Temperature in \(city):", value: "\(temperature)°C")
                        }

                        if let condition = weatherData?.current.weather_descriptions.first {
                            WeatherRow(title: "Conditions:", value: condition)
                        }

                        if let windSpeed = weatherData?.current.wind_speed {
                            WeatherRow(title: "Wind Speed:", value: "\(windSpeed) km/h")
                        }

                        if let feelslike = weatherData?.current.feelslike {
                            WeatherRow(title: "Feels Like:", value: "\(feelslike)°C")
                        }

                        if let uvIndex = weatherData?.current.uv_index {
                            WeatherRow(title: "UV Index:", value: "\(uvIndex)")
                        }

                        if let visibility = weatherData?.current.visibility {
                            WeatherRow(title: "Visibility:", value: "\(visibility) km")
                        }

                        GeometryReader { geometry in
                            GlassButton(label: "Check") {
                                fetchWeatherData()
                            }
                            .disabled(isFetchingData)
                            .frame(width: 100, height: 30)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }

                        if isFetchingData {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    private func backgroundForTemperature(_ temperature: Int?) -> some View {
        let gradientBackground: LinearGradient

        if let temperature = temperature {
            if temperature < 10 {
                gradientBackground = LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else if temperature < 20 {
                gradientBackground = LinearGradient(
                    gradient: Gradient(colors: [Color.green, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                gradientBackground = LinearGradient(
                    gradient: Gradient(colors: [Color.red, Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        } else {
            gradientBackground = LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }

        return gradientBackground
            .edgesIgnoringSafeArea(.all)
    }

    private func fetchWeatherData() {
        guard !city.isEmpty else { return }

        isFetchingData = true

        guard let escapedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://api.weatherstack.com/current?access_key=\(apiKey)&query=\(escapedCity)") else {
            isFetchingData = false
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            isFetchingData = false

            guard let data = data, error == nil else {
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    weatherData = decodedData
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct WeatherRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
