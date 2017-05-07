import { StackNavigator } from 'react-navigation';
import { HomeScreen, Legal, Howto, Viewemojis } from './components';

const App = StackNavigator({
  Main: { screen: HomeScreen },
  Legal: { screen: Legal },
  Howto: { screen: Howto },
  Viewemojis: { screen: Viewemojis }
  }
);

export default App;
