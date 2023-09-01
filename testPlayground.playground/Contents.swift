import UIKit

enum Temperature: String {
    case celsius = "celsius", farenheit = "farenheit", kelvin = "kelvin"
    var units: [String] {
        return ["celsius", "farenheit", "kelvin"]
    }
}

enum Length: String {
    case meters = "meters", kilometers = "kilometers", feet = "feet", yards = "yards", miles = "miles"
    static let units = ["meters", "kilometers", "feet", "yards", "miles"]
}

enum Time: String {
    case seconds = "seconds", minutes = "minutes", hours = "hours", days = "days"
    static let units = ["seconds", "minutes", "hours", "days"]
}

enum Volume: String {
    case milliliters = "milliliters", liters = "liters", cups = "cups", pints = "pints", gallons = "gallons"
    static let units = ["milliliters", "liters", "cups", "pints", "gallons"]
}

//var x = [Temperature.celsius, Length.feet, Time.days, Volume.cups] as [Any]
var y = Temperature.farenheit
print(y.units)
//for quantity in x {
//    print(quantity.units)
//}
let temperature: [String: Any] = [
    "quantityName":     "Temperature",
    "units":            ["Celsius", "Farenheit", "Kelvin"],
    "quantityUnits":    ["°C", "°F", "°K"]
]
