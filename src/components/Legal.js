import React, { Component } from 'react';
import { View, WebView } from 'react-native';

class Legal extends Component {
  static navigationOptions = {
    title: 'Legal'
  }
  render() {
    return (
       <View style={styles.containerStyle}>
       <WebView
       ref='webview'
       automaticallyAdjustContentInsets={false}
       source={{ uri: 'https://google.com/' }}
       javaScriptEnabled
       domStorageEnabled
       decelerationRate="normal"
       startInLoadingState
       />
       </View>
    );
  }
}


const styles = {
    containerStyle: {
      justifyContent: 'center',
      flex: 1
    }
};

export { Legal };
