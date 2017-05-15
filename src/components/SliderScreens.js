import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';
import Swiper from './swipe/';
import { Howto, SpeechBubbles, EmojiObjects, Dancer } from './';


class SliderScreens extends Component {
 constructor(props) {
    super(props);
    this.state = {
      items: [],
      screenindex: this.props.navigation.state.params.screenindex,
      navigate: this.props.navigation.navigate
    };
  }
  componentDidMount() {
    this.setState({
      items: []
    });
  }
  render() {
    const zindex = parseInt(this.state.screenindex, 10);
    return (
    <Swiper style={styles.wrapper} horizontal showsButtons showsPagination={false} index={zindex}>
          <View style={styles.slide1}>
              <Howto navigate={this.state.navigate} />
          </View>
          <View style={styles.slide3}>
               <EmojiObjects navigate={this.state.navigate} />
          </View>
          <View style={styles.slide2}>
               <SpeechBubbles navigate={this.state.navigate} />
          </View>
          <View style={styles.slide3}>
            <Dancer navigate={this.state.navigate} />
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
