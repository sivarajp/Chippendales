import React, { Component } from 'react';
import { View, Image, TouchableHighlight, ListView } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';

const listofImages = [
  require('../assets/images/speechbubbles/Cheers.png'),
  require('../assets/images/speechbubbles/DatD.png'),
  require('../assets/images/speechbubbles/HeCould.png'),
  require('../assets/images/speechbubbles/LastFling.png'),
  require('../assets/images/speechbubbles/Redick.png'),
  require('../assets/images/speechbubbles/TalkDirty.png'),
  require('../assets/images/speechbubbles/TooLit.gif'),
  require('../assets/images/speechbubbles/TruthDare.gif'),
  require('../assets/images/speechbubbles/Cheers.png'),
  require('../assets/images/speechbubbles/DatD.png'),
  require('../assets/images/speechbubbles/HeCould.png'),
  require('../assets/images/speechbubbles/LastFling.png'),
  require('../assets/images/speechbubbles/Redick.png'),
  require('../assets/images/speechbubbles/TalkDirty.png'),
  require('../assets/images/speechbubbles/TooLit.gif'),
  require('../assets/images/speechbubbles/TruthDare.gif')
];


class SpeechBubbles extends Component {

  constructor(props) {
    super(props);
    const dataSource = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1.guid !== r2.guid });
    this.state = {
      dataSource: dataSource.cloneWithRows(listofImages),
    };
  }

  renderRow(rowData) {
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
      alignItems: 'center'
    },
    list: {
        justifyContent: 'center',
        flexDirection: 'row',
        flexWrap: 'wrap',
        alignItems: 'center'
    },
    item: {
        margin: 3,
        width: 100,
        height: 100
    }
};

export { SpeechBubbles };
