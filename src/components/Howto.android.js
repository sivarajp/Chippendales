import React, { Component } from 'react';
import { StyleSheet, View, Text, ListView, TouchableHighlight } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';
import { Actions } from 'react-native-router-flux';


const listOfInstructions = [
  '1. Go to Settings.',
  '2. Language and input > Default Keyboard.',
  '3. Setup Input Methods.',
  '4. Choose Chippmoji.',
  '5. Chippmoji > Allow Full Access.'
];

class Howto extends Component {
  constructor(props) {
    super(props);
    const dataSource = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1.guid !== r2.guid });
    this.state = {
      dataSource: dataSource.cloneWithRows(listOfInstructions),
    };
  }

  renderRow(rowData) {
    return (
          <View>
            <Text
            style={styles.listItemStyle}
            numberOfLines={1}
            >{rowData}
            </Text>
          </View>
    );
  }

  render() {
    const { container, header, listContainer, helpText } = styles;
    return (
      <View style={container}>
         <View>
           <TouchableHighlight onPress={() => Actions.HomeScreen({ direction: 'fade' })}>
             <ResponsiveImage
                 source={{ uri: 'arrows' }} initWidth="25" initHeight="25"
             />
           </TouchableHighlight>
         </View>
         <View>
           <Text style={header}>HOW TO INSTALL</Text>
         </View>
         <View>
            <ListView
               style={listContainer} dataSource={this.state.dataSource}
               renderRow={this.renderRow.bind(this)}
            />
            <Text style={helpText}>NOTHING YOU TYPE WILL BE RECORDED</Text>
         </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    marginTop: 20
  },
  header: {
    paddingTop: 15,
    fontSize: 25,
    letterSpacing: 2,
    fontFamily: 'CircularStd-Bold',
    color: '#000000',
  },
  listContainer: {
    paddingTop: 25,
    paddingBottom: 10,
    flexWrap: 'wrap',
    margin: 0,
    flex: 1
  },
  listItemStyle: {
    paddingLeft: 20,
    fontSize: 16,
    color: '#000000',
    paddingTop: 15,
    fontFamily: 'CircularStd-Book',
  },
  helpText: {
    fontSize: 10,
    paddingLeft: 25,
    alignItems: 'flex-start',
    flex: 2,
    fontFamily: 'VisbyCF-Bold'
  }
});

export { Howto };
