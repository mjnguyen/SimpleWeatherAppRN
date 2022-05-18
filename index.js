import React, { useState, useEffect } from "react";
import { AppRegistry, Button, Text, View, TextInput } from "react-native";
import {
  SafeAreaView,
  FlatList,
  TouchableOpacity,
  StyleSheet,
  StatusBar,
} from "react-native";

import { NativeModules, NativeEventEmitter } from "react-native";
import { render } from "react-native/Libraries/Renderer/implementations/ReactNativeRenderer-prod";

import { default as Weather } from "./App/Views/Weather";

const { RNEventEmitter } = NativeModules;
const { MNWeatherServicesModule } = NativeModules;

const eventEmitter = new NativeEventEmitter(RNEventEmitter);

// styles

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  forecastButton: {
    backgroundColor: "blue",
    color: "white",
    fontWeight: "900",
    paddingHorizontal: 10,
    paddingVertical: 3,
    borderRadius: 10,
    alignSelf: "flex-start",
    marginHorizontal: "1%",
    // marginBottom: 6,
    textAlign: "center",
  },
});

const YourApp = () => {
  const [weatherData, setWeatherData] = useState();
  const [weatherDataLoaded, setWeatherDataLoaded] = useState(false);
  const [forecastDays, setForecastDays] = useState(5);
  const [forecastData, setForecastData] = useState();
  const [forecastDataLoaded, setForecastDataLoaded] = useState(false);

  eventEmitter.addListener("onReceiveForecasts", function (res) {
    let base = JSON.parse(res.response);
    console.log("got weather forecast for {" + base.city.name + " - " + forecastDays + "} results: ", typeof(base), base);
    setForecastData(base);
    setWeatherDataLoaded(false);
    setForecastDataLoaded(true);
  });

  eventEmitter.addListener("onReceiveWeatherConditions", function (res) {
    let base = JSON.parse(res.response);
    console.log("Setting weather data json is " + base);
    setWeatherData(base);
    setForecastDataLoaded(false);
    setWeatherDataLoaded(true);
  });

  var getForecast = function () {
    console.log("button pressed to get Forecast");
    // use native API manager to get forecast information
    // display in a table view
    console.log("forecast: " + {forecastDays} + forecastDays);
    MNWeatherServicesModule.getForecast('San Jose', forecastDays)

  };

  return (
    <SafeAreaView style={[styles.container, { padding: 0 }]}>
      <View
        style={[
          {
            flex: .20,
            height: '20%',
            flexDirection: "row",
            paddingLeft: 20,
          },
        ]}
      >
        <TextInput
          style={{ flex: 1, height: 50 }}
          placeholder="Number of days for Forecast"
          onChangeText={setForecastDays}
          keyboardType="numeric"
        />
        <View style={[styles.forecastButton, { height: 50, left: 0}]}>
          <Button
            color={'white'}
            onPress={() => getForecast()}
            title="Get Forecast"
          />
        </View>
      </View>
      <View
        style={[
          {
            flex: 1,
            backgroundColor: "lightblue",
          },
        ]}
      >
        {weatherDataLoaded && weatherData && <Weather data={weatherData} />}
        {forecastDataLoaded && forecastData && <Forecasts data={forecastData} />}
      </View>
    </SafeAreaView>
  );
};

AppRegistry.registerComponent("YourApp", () => YourApp);
