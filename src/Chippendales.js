import { StackNavigator } from 'react-navigation';
import { HomeScreen, Legal, SliderScreens } from './components';

const stackNavigatorConfig = {
  initialRouteName: 'Main',
  mode: 'modal',
  headerMode: 'none'
};

const App = StackNavigator({
  Main: { screen: HomeScreen },
  Legal: { screen: Legal },
  Howto: { screen: SliderScreens },
  Viewemojis: { screen: SliderScreens }
}, stackNavigatorConfig
);

export default App;
