// component to display the current weather conditions for a given city
import React from 'react'
import { Text, View, StyleSheet, FlatList, List } from 'react-native'
import moment from 'moment'
import {
  Card,
  CardItem,
  ListItem,
  Button,
  Icon,
  Title
} from 'react-native-elements'

// styles

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  cityName: {
    fontSize: 30,
    color: 'white',
    fontWeight: '900',
    textAlign: 'center'
  },
  header: {
    fontWeight: 900
  },
  item: {
    backgroundColor: '#f9c2ff',
    padding: 20,
    marginVertical: 8,
    marginHorizontal: 16
  },
  title: {
    fontSize: 32
  }
})


const Forecasts = ({ data }) => {
  const renderItem = ({ item }) => {

    var currentTime = "" + new Date( item.dt * 1000 );
    var timeString =moment(currentTime).calendar();
    console.log("Rendering Forecast for ...." + item.dt_txt);

    return (
    <View
      style={{
        flex: 1,
        padding: 5
      }}
    >
      <ListItem style={styles.card}>
        <Card>
          <Card.Title >{timeString}</Card.Title>
          <Card.Divider></Card.Divider>
        <Text>Temp: {item.main.temp}&deg;F</Text>
        <Text>
          Wind: {item.wind.speed}mph {item.wind.deg}&deg;
        </Text>
        </Card>
      </ListItem>
    </View>
  )
    }

  const renderHeader = () => {
    var subtitle = data.list.length + " day forecast"
    
    return (
      <>
    <Card.Title h2={true} style={[styles.cityName]}>
      {data.city.name}
    </Card.Title>
    <Card.FeaturedSubtitle h3={true} style={[styles.cityName]}>{subtitle}</Card.FeaturedSubtitle>
    </>
  )
    }
  return (
    <>
      <FlatList
        style={[{ flex: 1, backgroundColor: 'blue' }]}
        data={data.list}
        keyExtractor={(item, index) => String(index)}
        renderItem={renderItem}
        ListHeaderComponent={renderHeader}
        ListFooterComponent={renderHeader}
      />
    </>
  )
}

export default Forecasts
