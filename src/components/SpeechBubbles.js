import React, { Component } from 'react';
import { View, Image, TouchableHighlight, ListView } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';

const listofImages = [
  require('../assets/images/speechbubbles/Cheers.png'),
  require('../assets/images/speechbubbles/DatD.png'),
  require('../assets/images/speechbubbles/HeCould.png'),
  require('../assets/images/speechbubbles/LastFling.png'),
  require('../assets/images/speechbubbles/Ri-dick-ulous.png'),
  require('../assets/images/speechbubbles/TalkDirty.png'),
  require('../assets/images/speechbubbles/TooLit.gif'),
  require('../assets/images/speechbubbles/TruthDare.gif')
];


class SpeechBubbles extends Component {

  static navigationOptions = {
      title: 'View Emojis'
  }

  constructor(props) {
    super(props);
    const dataSource = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1.guid !== r2.guid });
    this.state = {
      dataSource: dataSource.cloneWithRows(listofImages),
      navigate: this.props.navigate
    };
  }

  renderRow(rowData) {
    console.log(rowData);
    return (
          <View style={styles.item}>
            <Image source={rowData} style={styles.item} />
          </View>
    );
  }

  render() {
    return (
       <View style={styles.container}>
          <View>
              <TouchableHighlight onPress={() => this.state.navigate('Main')}>
                <ResponsiveImage
                    source={{ uri: 'arrows' }} initWidth="25" initHeight="25"
                />
              </TouchableHighlight>
          </View>
          <View style={{ marginTop: 15 }}>
                <ResponsiveImage
                    source={require('../assets/images/header/SpeechBubbleIcon.png')}
                    initWidth="100" initHeight="100"
                />
          </View>
          <View>
             <ListView
                contentContainerStyle={styles.list}
                dataSource={this.state.dataSource}
                renderRow={this.renderRow.bind(this)}
             />
          </View>
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
    list: {
        flexDirection: 'row',
        flexWrap: 'wrap'
    },
    item: {
        margin: 3,
        width: 100,
        height: 100
    }
};

export { SpeechBubbles };
