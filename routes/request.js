var express = require('express');
var router = express.Router();

/* GET users listing. */
router.post('/', function(req, res) {
  //console.log(req.body);
  var jsonObj = req.body;

  if(jsonObj['tags[]']) {
    jsonObj['tags'] = jsonObj['tags[]'];
    delete jsonObj['tags[]'];
  }

  if(typeof jsonObj['tags'] == 'string' || jsonObj['tags'] instanceof String) {
    var arrayt = [];
    arrayt[] = jsonObj['tags'];
    jsonObj['tags'] = arrayt;
  }

  //console.log(jsonObj['tags[]'][0]);
  //jsonBuilder.push({cityFrom: req.body.cityFrom, cityTo: req.body.cityTo, startDate: req.body.startDate, endDate: req.body.endDate});

  var exec = require('child_process').exec;
  var command = 'java -cp DFW.jar Main "' + JSON.stringify(jsonObj) + '"';
  console.log(command);
  exec(command, function (error, stdout, stderr) {
    //if(error) console.log(error);
    //if(stderr) console.log(stderr);
    if(stdout) console.log(stdout);
    res.setHeader('Connection', 'close');
    res.contentType('application/json');
    res.send(JSON.stringify(JSON.parse(stdout)));
  });

  //res.contentType('application/json');
  //res.send(JSON.stringify(jsonBuilder));
});

module.exports = router;
