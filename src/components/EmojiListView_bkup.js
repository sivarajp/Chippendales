import React, { Component } from 'react';
import { View, TouchableOpacity, ListView } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';
import Share from 'react-native-share';
import RFNS from 'react-native-fs';

class EmojiListView extends Component {

  constructor(props) {
    super(props);
    const dataSource = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1.guid !== r2.guid });
    this.state = {
      dataSource: dataSource.cloneWithRows(this.props.emojis)
    };
  }

  shareImage(encodedImage) {
    Share.open({
      title: 'Chippmoji',
      message: '',
      url: encodedImage,
      subject: 'Chippmoji'
    });
  }

  renderRow(rowData) {
    //console.log(RFNS.MainBundlePath)

    // RFNS.readDir(RFNS.MainBundlePath+'/images/speeches') // On Android, use "RNFS.DocumentDirectoryPath" (MainBundlePath is not defined)
    //   .then((result) => {
    //     console.log('GOT RESULT', result);
    //   })

    RFNS.readFile(RFNS.MainBundlePath +  '/images/speeches/basic480.png', 'base64').then (
      res => this.setState({ base64: 'data:image/png;base64,' + res })
    );
    console.log('image', this.state.base64)
    return (
        <TouchableOpacity onPress={() => { this.shareImage(this.state.base64); }}>
          <View style={styles.item}>
            <ResponsiveImage
             source={{ uri: this.state.base64 }} initWidth="100" initHeight="100"
            />
          </View>
        </TouchableOpacity>
    );
  }

  render() {
    return (
       <View style={styles.container}>
             <ListView
                initialListSize={50}
                contentContainerStyle={styles.list}
                dataSource={this.state.dataSource}
                renderRow={this.renderRow.bind(this)}
             />
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
        marginLeft: 1,
        marginRight: 1,
        paddingBottom: 10
    }
};

export { EmojiListView };
