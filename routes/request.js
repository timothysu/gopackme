var express = require('express');
var router = express.Router();

/* GET users listing. */
router.post('/', function(req, res) {
  var jsonBuilder = [];
  //jsonBuilder.push({cityFrom: req.body.cityFrom, cityTo: req.body.cityTo, startDate: req.body.startDate, endDate: req.body.endDate});

  var exec = require('child_process').exec;
  exec('java -cp DFW.jar Main "' + req.body.tags + '"', function (error, stdout, stderr) {
    res.send(JSON.stringify(stdout));
  });

  //res.contentType('application/json');
  //res.send(JSON.stringify(jsonBuilder));
});

module.exports = router;
