import React, { Component } from 'react';
import { View } from 'react-native';

class Viewemojis extends Component {
  static navigationOptions = {
    title: 'View Emojis'
  }
  render() {
    return (
       <View style={styles.containerStyle} />
    );
  }
}

const styles = {
    containerStyle: {
      justifyContent: 'center',
      flex: 1
    }
};

export { Viewemojis };
