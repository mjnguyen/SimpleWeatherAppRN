// component to display the current weather conditions for a given city
import React from "react";
import { Text, View, StyleSheet } from "react-native";
import { DataTable } from "react-native-paper";
import moment from "moment";

// styles

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  cityName: {
    fontSize: 30,
    color: "white",
    backgroundColor: "grey",
    fontWeight: "900",
    textAlign: "center",
  },
  header: {
    fontWeight: 900
  },
  content: {},
});

const Weather = ({ data }) => {

    var sunsetTimestamp = new Date( data.sys.sunset * 1000 );
    var sunset =moment(sunsetTimestamp).format("h:MM:ss a");
    var sunriseTimestamp = new Date( data.sys.sunrise * 1000);
    var sunrise = moment(sunriseTimestamp).format("h:MM:ss a");

  return (
    <>
      <View style={[styles.container, { flexDirection: "column" }]}>
        <Text style={[styles.cityName]}>{data.name}</Text>
        <View style={[styles.container, { flexDirection: "row" }]}>
          <DataTable>
            <DataTable.Row>
              <DataTable.Cell style={[styles.header]}>
                Current temp
              </DataTable.Cell>
              <DataTable.Cell style={[styles.content]}>
                {data.main.temp}&deg;F
              </DataTable.Cell>
            </DataTable.Row>

            <DataTable.Row>
                <DataTable.Cell>Sunrise</DataTable.Cell>
                <DataTable.Cell style={[styles.content]}>{sunrise}</DataTable.Cell>
            </DataTable.Row>

            <DataTable.Row>
                <DataTable.Cell>Sunset</DataTable.Cell>
                <DataTable.Cell style={[styles.content]}>{sunset}</DataTable.Cell>
            </DataTable.Row>

            <DataTable.Row>
                <DataTable.Cell><Text>Latitude:</Text></DataTable.Cell>
                <DataTable.Cell style={[styles.content]}>{data.coord.lat}</DataTable.Cell>
            </DataTable.Row>

            <DataTable.Row>
                <DataTable.Cell><Text>Longitude:</Text></DataTable.Cell>
                <DataTable.Cell style={[styles.content]}>{data.coord.lon}</DataTable.Cell>
            </DataTable.Row>

            <DataTable.Row>
                <DataTable.Cell><Text>Wind:</Text></DataTable.Cell>
                <DataTable.Cell style={[styles.content]}>{data.wind.speed} mph {data.wind.deg}&deg;</DataTable.Cell>
            </DataTable.Row>

          </DataTable>
        </View>
      </View>
    </>
  );
};

export default Weather;
