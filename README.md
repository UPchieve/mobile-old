# UPchieve iOS client

> Mobile tutoring app, native iOS version written in Swift

## Changes supposed to be made to server

Since the iOS version of Socket.IO cannot emit JavaScript objects directly, changes are supposed to be made to router/api/sockets.js file in server to handle JSON data emitted by iOS client. 

The following functions are supposed be modified: 
```
socket.on('join', function(data)
socket.on('message', function(data)
socket.on('drawClick', function(data)
socket.on('saveImage', function(data)
socket.on('undoClick', function(data)
socket.on('clearClick', function(data)
socket.on('drawing', function(data)
socket.on('end', function(data)
socket.on('changeColor', function(data)
socket.on('changeWidth', function(data)
socket.on('dragStart', function(data)
socket.on('dragAction', function(data)
socket.on('dragEnd', function(data)
socket.on('insertText', function(data)
socket.on('resetScreen', function(data)
```

An example of possible way of changing (Take drawing for example): 

Before changing: 
```
socket.on('drawing', function(data) {
  if (!data || !data.sessionId) return;
  socket.broadcast.to(data.sessionId).emit('draw');
});
```
After changing:
```
socket.on('drawing', function(data) {

  # new code at the beginning
  if (!data.sessionId) {
    data = JSON.parse(data)
  }

  # everything remains the same
  if (!data || !data.sessionId) return;
  socket.broadcast.to(data.sessionId).emit('draw');
});
```

The changes made in the example above will make the server work for both the web client and the iOS client.

## Server Configurations

All the server configurations, including the address of the server, are stored in UPchieve/UPchieve/ServerAccess/ServerConfiguration.swift

For detailed explanation on how things work, checkout the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
