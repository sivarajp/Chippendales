import React from 'react';
import { Text, View } from 'react-native';

const Button = (styles) => {
  const { buttonStyle, textStyle, buttonText } = styles;
  return (
     <View style={buttonStyle}>
       <Text style={textStyle}>{buttonText}</Text>
     </View>
);
};

export { Button };
