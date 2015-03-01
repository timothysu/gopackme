var express = require('express');
var router = express.Router();

/* GET users listing. */
router.post('/', function(req, res) {
  console.log(req.body);
  var jsonObj = req.body;
  console.log(jsonObj['tags']);
  //jsonBuilder.push({cityFrom: req.body.cityFrom, cityTo: req.body.cityTo, startDate: req.body.startDate, endDate: req.body.endDate});

  var exec = require('child_process').exec;
  exec('java -cp DFW.jar Main "' + jsonObj['tags[]'][0] + '"', function (error, stdout, stderr) {
    if(error) console.log(error);
    if(stderr) console.log(stderr);
    res.contentType('application/json');
    res.send(JSON.stringify(stdout));
  });

  //res.contentType('application/json');
  //res.send(JSON.stringify(jsonBuilder));
});

module.exports = router;
