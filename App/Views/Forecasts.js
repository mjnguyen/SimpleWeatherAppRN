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
