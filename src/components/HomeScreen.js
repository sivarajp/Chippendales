import React, { Component } from 'react';
import { View, Text, Platform, Linking, TouchableWithoutFeedback } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';
import { Button } from './';
import { COMPANY_NAME, LEGAL, SUPPORT, HOWTO, VIEWEMOJI } from './Constants';

class HomeScreen extends Component {

  static navigationOptions = {
    header: null
  }

  handleClick = (url) => {
      Linking.canOpenURL(url).then(supported => {
        if (supported) {
          Linking.openURL(url);
        } else {
          const str = 'Invalid Url:';
          console.log(str, url);
        }
      });
    };

  render() {
    const { navigate } = this.props.navigation;
    const { containerStyle, imageStyle, howtoButtonStyle, howtoButtontextStyle,
            viewEmojiButtonStyle, viewEmojiButtontextStyle,
            footerStyle, companyStyle, companyNameStyle,
            legalContainerStyle, legalTextStyle, supportTextStyle } = styles;
    let companyName = COMPANY_NAME;
    let legalText = LEGAL;
    let legalSupport = SUPPORT;
    //letterSpacing not working for android, added some hack
    if (Platform.OS === 'android') {
      companyName = companyName.split('').join('\u200A'.repeat(3));
      legalText = legalText.split('').join('\u200A'.repeat(2));
      legalSupport = legalSupport.split('').join('\u200A'.repeat(2));
    }
    return (
      <View style={containerStyle}>
        <View style={{ flex: 1, alignItems: 'center' }}>
          <View style={imageStyle}>
             <ResponsiveImage
             source={{ uri: 'home_screen_icon' }} initWidth="135" initHeight="235"
             />
          </View>
          <View>
            <Button
            onPress={() => navigate('Howto', { screenindex: '0' })}
            buttonText={HOWTO} buttonStyle={howtoButtonStyle}
            textStyle={howtoButtontextStyle}
            />
          </View>
          <View>
            <Button
              onPress={() => navigate('SpeechBubbles', { screenindex: '1' })}
            buttonText={VIEWEMOJI} buttonStyle={viewEmojiButtonStyle}
            textStyle={viewEmojiButtontextStyle}
            />
          </View>
        </View>

        <View style={footerStyle}>
          <View style={companyStyle}>
             <ResponsiveImage source={{ uri: 'home_screen_logo' }} initWidth="50" initHeight="50" />
             <TouchableWithoutFeedback onPress={() => this.handleClick('http://www.chippmoji.com')}>
              <View>
                <Text style={companyNameStyle}>{companyName}</Text>
              </View>
             </TouchableWithoutFeedback>
          </View>
          <View style={legalContainerStyle}>
             <TouchableWithoutFeedback onPress={() => navigate('Legal')}>
             <View>
              <Text style={legalTextStyle}>{legalText}</Text>
             </View>
             </TouchableWithoutFeedback>
             <Text>|</Text>
             <Text style={supportTextStyle}>{legalSupport}</Text>
          </View>
        </View>
      </View>
    );
  }

}


const styles = {
  containerStyle: {
    flex: 1
  },
  imageStyle: {
    paddingTop: 50,
    paddingBottom: 20
  },
  howtoButtonStyle: {
      padding: 10,
      margin: 10,
      backgroundColor: '#000000',
  },
  howtoButtontextStyle: {
      paddingLeft: 10,
      paddingRight: 10,
      fontSize: 40,
      letterSpacing: 2,
      textAlign: 'center',
      color: '#FFFFFF',
      fontFamily: 'CircularStd-Bold',
  },
  viewEmojiButtonStyle: {
      padding: 10,
      margin: 10,
      backgroundColor: '#EB0C8C',
  },
  viewEmojiButtontextStyle: {
      fontSize: 40,
      letterSpacing: 2,
      textAlign: 'center',
      color: '#FFFFFF',
      fontFamily: 'CircularStd-Bold',
  },
  companyStyle: {
    flexDirection: 'row',
    alignItems: 'center'
  },
  companyNameStyle: {
    paddingLeft: 15,
    fontSize: 25,
    letterSpacing: 3,
    fontFamily: 'CircularStd-Bold',
    fontWeight: 'bold',
    textAlignVertical: 'center',
    color: '#000000'
  },
  legalContainerStyle: {
    paddingLeft: 50,
    flexDirection: 'row'
  },
  legalTextStyle: {
    letterSpacing: 2,
    paddingRight: 10,
    fontFamily: 'CircularStd-Book'
  },
  supportTextStyle: {
    letterSpacing: 2,
    paddingLeft: 10,
    fontFamily: 'CircularStd-Book'
  },
  footerStyle: {
    height: 75,
    alignItems: 'center',
    marginBottom: 10
  }
};

export { HomeScreen };
