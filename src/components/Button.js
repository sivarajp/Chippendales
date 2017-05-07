import React from 'react';
import { Text, TouchableOpacity } from 'react-native';

const Button = (styles) => {
  const { buttonStyle, textStyle, buttonText, onPress } = styles;
  return (
     <TouchableOpacity onPress={onPress} style={buttonStyle}>
       <Text style={textStyle}>{buttonText}</Text>
     </TouchableOpacity>
);
};

export { Button };
