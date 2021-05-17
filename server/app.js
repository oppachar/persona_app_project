// const port = 8000
// var app = require('express')();
// var http = require('http').Server(app);
// var io = require('socket.io')(http);

// const firebaseRouter = require('./routers/firebase/service');

// app.get('/', (req, res) => {
//   res.send('Hello World!')
// })
// app.use('/firebase',firebaseRouter);

// io.on('connection', function(socket){ 
//   socket.on('send_message', function(msg){ 
//       io.emit('receive_message', msg); }
//   ); 
// });

// http.listen(port, () => {
//   console.log(`Example app listening at http://localhost:${port}`)
// })

var app = require('express')(); 
var http = require('http').Server(app); 
var io = require('socket.io')(http); 

app.get('/', function(req, res){ 
    res.send("hi"); 
}); 
// app.get("/chat",(req,res) =>{
//     res.sendFile('../index.html');
// });


io.on('connection', function(socket){ 
    socket.on('send_message', function(msg){ 
        console.log(msg)
        io.emit('receive_message', msg); }
    ); 
});


http.listen(8000, function(){ console.log('listening on *:8000'); });