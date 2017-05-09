import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';
import Swiper from './swipe/';
import Howto from './Howto';

class SliderScreens extends Component {
 constructor(props) {
    super(props);
    this.state = {
      items: [],
      screenindex: this.props.navigation.state.params.screenindex
    };
  }
  componentDidMount() {
    this.setState({
      items: [
        { title: 'Hello Swiper', css: styles.slide1 },
        { title: 'Beautiful', css: styles.slide2 },
        { title: 'And simple', css: styles.slide3 }
      ]
    });
  }
  render() {
    const zindex = parseInt(this.state.screenindex, 10);
    return (
    <Swiper style={styles.wrapper} horizontal showsButtons showsPagination={false} index={zindex}>
          <View style={styles.slide1}>
              <Howto />
          </View>
          <View style={styles.slide2}>
            <Text style={styles.text}>View Emojis</Text>
          </View>
          <View style={styles.slide3}>
            <Text style={styles.text}>View Gifs</Text>
          </View>
          <View style={styles.slide3}>
            <Text style={styles.text}>View Sticker</Text>
          </View>
        </Swiper>
    );
  }
}

const styles = {
  wrapper: {
  },
  slide1: {
    flex: 1,
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
    color: '#000',
    fontSize: 30,
    fontWeight: 'bold'
  }
};

export { SliderScreens };
