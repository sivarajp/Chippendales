import React, { Component } from 'react';
import { View, Image, TouchableOpacity, ListView } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';
import { listofImages } from './SpeechBubblesConst'
import Share from 'react-native-share';

class SpeechBubbles extends Component {

  constructor(props) {
    super(props);
    const dataSource = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1.guid !== r2.guid });
    this.state = {
      dataSource: dataSource.cloneWithRows(listofImages)
    };
  }

  shareImage(encodedImage) {
    Share.open({
      title: 'Chippmoji',
      message: '',
      url: encodedImage,
      subject: "Chippmoji"
    });
  }

  renderRow(rowData) {
    return (
        <TouchableOpacity onPress={()=>{ this.shareImage(rowData.encodedImage)}}>
          <View style={styles.item}>
            <ResponsiveImage source={rowData.img } initWidth="100" initHeight="100" />
          </View>
        </TouchableOpacity>
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
        margin: 3
    }
};

export { SpeechBubbles };
