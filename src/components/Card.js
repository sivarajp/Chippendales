
import React from 'react';
import { View, Text } from 'react-native';

const Card = () => {
  const { containerStyle } = styles;
  return (
     <View style={containerStyle}>
       <Text>Card</Text>
     </View>
   );
};

const styles = {
  containerStyle: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  textStyle: {
    fontSize: 20,
    textAlign: 'center'
  }

};

export { Card };
