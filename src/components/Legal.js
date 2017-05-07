import React from 'react';
import { View, WebView } from 'react-native';

const Legal = () => {
  return (
    <View style={{ flex: 1 }}>
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
};


export { Legal };
