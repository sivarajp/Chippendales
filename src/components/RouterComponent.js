import React, { Component } from 'react';
import { Router, Scene, BrowserHistory, ActionConst } from 'react-native-router-flux';
import { HomeScreen, Howto, SliderScreens, Legal } from './';


class RouterComponent extends Component {
  render() {
    return (
     <Router history={BrowserHistory}>
        <Scene key="root">
          <Scene
              key="HomeScreen" component={HomeScreen}
                initial hideNavBar type={ActionConst.RESET}
          />
          <Scene key="Howto" component={Howto} />
          <Scene key="SliderScreens" component={SliderScreens}  hideNavBar/>
          <Scene key="Legal" component={Legal} />
        </Scene>
      </Router>
    );
  }
}

export { RouterComponent };
