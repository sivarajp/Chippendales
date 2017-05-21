import React, { Component } from 'react';
import { View, WebView, TouchableHighlight } from 'react-native';
import { Actions } from 'react-native-router-flux';
import ResponsiveImage from 'react-native-responsive-image';

class Legal extends Component {

  render() {
    return (
      <View style={styles.containerStyle}>
          <View style={{ alignItems: 'center', marginTop: 20 }}>
            <TouchableHighlight onPress={() => Actions.HomeScreen({ direction: 'fade' })}>
              <ResponsiveImage
                  source={{ uri: 'arrows' }} initWidth="25" initHeight="25"
              />
            </TouchableHighlight>
          </View>
          <WebView
          ref='webview'
          automaticallyAdjustContentInsets={false}
          source={{ uri: 'https://www.chippmoji.com/legal' }}
          javaScriptEnabled
          domStorageEnabled
          decelerationRate="normal"
          startInLoadingState
          scalesPageToFit
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
