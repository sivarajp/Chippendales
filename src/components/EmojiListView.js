import React, { Component } from 'react';
import { View, TouchableOpacity, ListView } from 'react-native';
import ResponsiveImage from 'react-native-responsive-image';
import Share from 'react-native-share';
import PaginatedListView from 'react-native-paginated-listview'

class EmojiListView extends Component {

  constructor(props) {
    super(props);
    this.state = {
      emojis: this.props.emojis
    };
    this.onFetch = this.onFetch.bind(this);
  }
  onFetch(page, count) {
      return new Promise((resolve, reject) => {
        let startIndex = (page - 1) * 20
        let endIndex = startIndex + 20
        console.log("onfetch")
        if (startIndex < this.state.emojis.length) {
          if (endIndex > this.state.emojis.length) {
            resolve(this.state.emojis.slice(startIndex, this.state.emojis.length))
          } else {
            resolve(this.state.emojis.slice(startIndex, endIndex))
          }
        }
      });
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
    return (
        <TouchableOpacity key={rowData.img} onPress={() => { this.shareImage(rowData.encodedImage); }}>
          <View key={rowData.img} style={styles.item}>
            <ResponsiveImage
             source={{ uri: rowData.encodedImage }} initWidth="100" initHeight="100"
            />
          </View>
        </TouchableOpacity>
    );
  }

  render() {
    return (
       <View style={styles.container}>
         <PaginatedListView
            renderRow={this.renderRow.bind(this)}
            itemsPerPage={20}
            initialListSize={20}
            onFetch={this.onFetch}
            contentContainerStyle={styles.list}
            removeClippedSubviews
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
