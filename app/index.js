const express = require('express')
const app = express()


app.get('/demo/healthCheck', (req, res) => {
    res.send({
      version:"DEMO APP HEALTH CHECK",
      timeLeft
    })
})

app.use(homepage)

function homepage(req, res) {
  res.status(200).send('Demo is up and running')
}

const port = process.env.PORT || 80

app.listen(port, () => console.log('Demo app is running ' + port))