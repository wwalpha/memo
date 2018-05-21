### Install
redux-devtools-extension(browser plugin)

### Enable HMR
```
const store = createStore(
  reducer,
  // enable plugin
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
  applyMiddleware(api, logger),
);

// enable reducer HMR
if(module.hot) {
  module.hot.accept('../reducers', () => store.replaceReducer(reducer));
}
```
