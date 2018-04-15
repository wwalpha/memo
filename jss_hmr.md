### Install
```
npm install react-hot-loader --save
```

### Enable JSS HMR
```
import { hot } from 'react-hot-loader';

class App extends Component {
  ...
}

export default hot(module)(App);
```