const express = require('express')
const app = express()
const port = 8000
const firebaseRouter = require('./routers/firebase/service');


app.get('/', (req, res) => {
  res.send('Hello World!')
})
app.use('/firebase',firebaseRouter);


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})