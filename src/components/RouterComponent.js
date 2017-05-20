import React, { Component } from 'react';
import { Router, Scene, BrowserHistory } from 'react-native-router-flux';
import { HomeScreen, Howto, SliderScreens, Legal } from './';


class RouterComponent extends Component {
  render() {
    return (
     <Router history={BrowserHistory}>
        <Scene key="root">
          <Scene key="HomeScreen" component={HomeScreen} initial hideNavBar />
          <Scene key="Howto" component={Howto} />
          <Scene key="SliderScreens" component={SliderScreens} />
          <Scene key="Legal" component={Legal} />
        </Scene>
      </Router>
    );
  }
}

export { RouterComponent };
