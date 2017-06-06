import React, { Component } from 'react';
import {
  View,
  Text,
  TouchableHighlight
} from 'react-native';
import { Actions } from 'react-native-router-flux';
import ResponsiveImage from 'react-native-responsive-image';
import Swiper from './swipe/';
import { SpeechBubbles, EmojiObjects, Dancer } from './';

class SliderScreens extends Component {
 constructor(props) {
    super(props);
    this.state = {
      items: [],
    };
  }
  componentDidMount() {
    this.setState({
      items: []
    });
  }
  render() {
    const zindex = 0;//parseInt(this.state.screenindex, 10);
    return (
    <View style={styles.container}>
      <View style={styles.imageStyle}>
         <TouchableHighlight onPress={() => Actions.HomeScreen({ direction: 'fade' })}>
           <ResponsiveImage
               source={{ uri: 'arrows' }} initWidth="35" initHeight="35"
           />
         </TouchableHighlight>
      </View>
      <View>
        <Text style={styles.text}>SEND CHIPPMOJI</Text>
      </View>

      <Swiper
      style={styles.wrapper} horizontal showsButtons showsPagination index={zindex}
      buttonWrapperStyle={styles.buttonWrapperStyle}
      loadMinimal
      loadMinimalSize={2}
      nextButton={<ResponsiveImage
          source={{ uri: 'rightarrows' }} initWidth="35" initHeight="35"
      />}
      paginationStyle={{ alignItems: 'flex-end' }}
      >
            <View style={styles.slide3}>
                 <EmojiObjects />
            </View>
            <View style={styles.slide2}>
                 <Dancer />
            </View>
            <View style={styles.slide3}>
                 <SpeechBubbles />
            </View>
      </Swiper>
    </View>
    );
  }
}

const styles = {
  container: {
    flex: 1,
    alignItems: 'center',
    marginTop: 20
  },
  wrapper: {
    flex: 1
  },
  slide1: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF'
  },
  slide2: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF'
  },

  slide3: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF'
  },
  text: {
    marginTop: 10,
    color: '#000',
    fontSize: 25,
    fontWeight: 'bold'
  },
  buttonWrapperStyle: {
    flex: 0.5,
    backgroundColor: 'transparent',
    position: 'relative',
    justifyContent: 'center',
    alignItems: 'center',
    paddingBottom: 10
  }
};

export { SliderScreens };
