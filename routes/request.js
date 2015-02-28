var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res) {
  var jsonBuilder = [];
  jsonBuilder.push({cityFrom: req.body.cityFrom, cityTo: req.body.cityTo, startDate: req.body.startDate, endDate: req.body.endDate});
  res.contentType('application/json');
  res.send(JSON.stringify(jsonBuilder));
});

module.exports = router;
