import React from 'react';
import { View, Text } from 'react-native';

const CardSection = () => {
  const { containerStyle } = styles;
  return (
     <View style={containerStyle}>
       <Text>Card Section</Text>
     </View>
);
};


const styles = {
    containerStyle: {
      justifyContent: 'center'
    }
};

export { CardSection };
