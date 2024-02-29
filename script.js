const fs = require('fs')

const images = fs.readdirSync('./images')
console.log(images)

fs.writeFile('images.json',JSON.stringify(images), 'utf-8', function(err){
    console.log(err)
})