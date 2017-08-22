import React, { Component } from 'react';
import {
  View,
  Text,
  TouchableHighlight
} from 'react-native';
import { Actions } from 'react-native-router-flux';
import ResponsiveImage from 'react-native-responsive-image';
import Swiper from './swipe/';
import { EmojiListView } from './';
import { speechconst } from './SpeechBubblesConst';
import { dancerconst } from './DancerConst';
import { lipsconst } from './LipsConst';

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
       horizontal showsButtons showsPagination index={zindex} bounces={false}
       buttonWrapperStyle={styles.buttonWrapperStyle}
       nextButton={<ResponsiveImage
          source={{ uri: 'rightarrows' }} initWidth="35" initHeight="35"
      />}
      loadMinimal
      loadMinimalSize={1}
      >
            <View style={styles.slide}>
                 <EmojiListView emojis={dancerconst} />
            </View>
            <View style={styles.slide}>
                 <EmojiListView emojis={lipsconst} />
            </View>
            <View style={styles.slide}>
                 <EmojiListView emojis={speechconst} />
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
  slide: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF'
  },
  text: {
    marginTop: 5,
    color: '#000',
    fontSize: 25,
    fontWeight: 'bold'
  },
  buttonWrapperStyle: {
    backgroundColor: 'transparent',
    position: 'relative',
    justifyContent: 'center',
    alignItems: 'center',
    paddingBottom: 10,
    paddingTop: 10
  }
};

export { SliderScreens };
