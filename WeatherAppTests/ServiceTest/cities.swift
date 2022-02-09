//
//  cities.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 22.01.2022.
//

import Foundation
@testable import WeatherApp

let weather = Weather(id: 100,
                      main: "main",
                      description: "description",
                      icon: "icon")

let currentWeather = CurrentWeather(dt: 100,
                                    sunrise: 200,
                                    sunset: 300,
                                    temp: 400.4,
                                    feels_like: 500,
                                    pressure: 600,
                                    humidity: 700,
                                    dew_point: 800.8,
                                    clouds: 900,
                                    uvi: 1000.1,
                                    visibility: 100,
                                    wind_speed: 200.2,
                                    wind_gust: nil,
                                    wind_deg: 300.3,
                                    rain: nil,
                                    snow: nil,
                                    weather: [weather])

let hourlyWeather = HourlyWeather(dt: 100,
                                  temp: 200.2,
                                  feels_like: 300.3,
                                  pressure: 400,
                                  humidity: 500,
                                  dew_point: 600,
                                  uvi: 700,
                                  clouds: 800,
                                  visibility: 900,
                                  wind_speed: 1000.1,
                                  wind_gust: nil,
                                  wind_deg: 100.1,
                                  pop: 200.2,
                                  rain: nil,
                                  snow: nil,
                                  weather: [weather])

let temp = Temp(morn: 100.1,
                day: 200.2,
                eve: 300.3,
                night: 400.4,
                min: 500.5,
                max: 600.6)

let feelLike = Feels_like(morn: 100.1,
                          day: 200.2,
                          eve: 300.3,
                          night: 400.4
                          )

let dailyWeather = DailyWeather(dt: 100,
                                sunrise: 200,
                                sunset: 300,
                                moonrise: 400,
                                moonset: 500,
                                moon_phase: 600.6,
                                temp: temp,
                                feels_like: feelLike,
                                pressure: 700,
                                humidity: 800,
                                dew_point: 900.9,
                                wind_speed: 100.1,
                                wind_gust: nil,
                                wind_deg: 200,
                                clouds: 300,
                                uvi: 400.4,
                                pop: 500.5,
                                rain: nil,
                                snow: nil,
                                weather: [weather])
                                  
let weatherModel = WeatherResponse(lat: 123,
                              lon: -123,
                              timezone: "timezone",
                              timezone_offset: 1000,
                              current: currentWeather,
                              hourly: [hourlyWeather, hourlyWeather],
                              daily: [dailyWeather, dailyWeather, dailyWeather],
                              alerts: nil)

let city1 = CityModel(adminCode1: "adminCode1",
                     lng: "123",
                     geonameId: 0,
                     toponymName: "toponymName",
                     countryId: "123",
                     fcl: "fcl",
                     population: 1,
                     countryCode: "",
                     name:  "city1",
                     fclName: "fclName",
                     countryName: "countryName",
                     fcodeName: "fcodeName",
                     adminName1: "adminName1",
                     lat: "-123",
                     fcode: "fcode")

let city2 = CityModel(adminCode1: "adminCode1",
                     lng: "123",
                     geonameId: 1,
                     toponymName: "toponymName",
                     countryId: "123",
                     fcl: "fcl",
                     population: 1,
                     countryCode: "",
                     name:  "city2",
                     fclName: "fclName",
                     countryName: "countryName",
                     fcodeName: "fcodeName",
                     adminName1: "adminName1",
                     lat: "-123",
                     fcode: "fcode")

let city3 = CityModel(adminCode1: "adminCode1",
                     lng: "123",
                     geonameId: 2,
                     toponymName: "toponymName",
                     countryId: "123",
                     fcl: "fcl",
                     population: 1,
                     countryCode: "",
                     name:  "city3",
                     fclName: "fclName",
                     countryName: "countryName",
                     fcodeName: "fcodeName",
                     adminName1: "adminName1",
                     lat: "-123",
                     fcode: "fcode")

let city4 = CityModel(adminCode1: "adminCode1",
                     lng: "123",
                     geonameId: 3,
                     toponymName: "toponymName",
                     countryId: "123",
                     fcl: "fcl",
                     population: 1,
                     countryCode: "",
                     name:  "city4",
                     fclName: "fclName",
                     countryName: "countryName",
                     fcodeName: "fcodeName",
                     adminName1: "adminName1",
                     lat: "-123",
                     fcode: "fcode")

let city5 = CityModel(adminCode1: "adminCode1",
                     lng: "123",
                     geonameId: 4,
                     toponymName: "toponymName",
                     countryId: "123",
                     fcl: "fcl",
                     population: 1,
                     countryCode: "",
                     name:  "city5",
                     fclName: "fclName",
                     countryName: "countryName",
                     fcodeName: "fcodeName",
                     adminName1: "adminName1",
                     lat: "-123",
                     fcode: "fcode")

let entity1 = CWEntity (city: city1,
                        weather: weatherModel)
let entity2 = CWEntity (city: city2,
                        weather: weatherModel)
let entity3 = CWEntity (city: city3,
                    weather: weatherModel)
let entity4 = CWEntity (city: city4,
                        weather: weatherModel)
let entity5 = CWEntity (city: city5,
                        weather: weatherModel)

let entityArray = [entity1, entity2, entity3, entity4, entity5]
