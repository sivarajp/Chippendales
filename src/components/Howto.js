import React, { Component } from 'react';
import { View } from 'react-native';

class Howto extends Component {
  static navigationOptions = {
    title: 'How To'
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

export { Howto };
