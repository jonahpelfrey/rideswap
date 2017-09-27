'use strict';
/** 
 * =============================================================================
 * Imports
 * =============================================================================
 */
var express = require('express');
var controller = require('./model.controller');
var router = express.Router();

/** 
 * =============================================================================
 * Routes
 * =============================================================================
 */
router.get('/make/models', controller.getModelsForMake);

module.exports = router;