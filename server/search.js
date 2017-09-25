var request = require('request');
var cheerio = require('cheerio');
var config = require('./config.js');
var DataService = require('./service.js');
var Q = require('q');

const URL = 'http://www.swapalease.com/lease/BMW/3-Series/search.aspx?zip=53562&ltp=all';

const pagUrl = 'http://www.swapalease.com/lease/BMW/3-Series/search.aspx?page=4&zip=53562&ltp=all';

const chkUrl = 'http://www.swapalease.com/lease/Cadillac/Escalade/search.aspx?zip=53562&ltp=all';

const baseUrl = 'http://www.swapalease.com';

const check = 'http://www.swapalease.com/lease/Alabama/search.aspx?zip=53703';

const make = 'http://www.swapalease.com/lease/BMW/search.aspx?&ltp=all';

const year = 'http://www.swapalease.com/lease/BMW/4-Series/search.aspx';

DataService.testCase(make);















