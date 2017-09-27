'use strict';
/** 
 * =============================================================================
 * Imports
 * =============================================================================
 */
var cheerio = require('cheerio');
var request = require('request');

/** 
 * =============================================================================
 * Public Functions
 * =============================================================================
 */
exports.getModelList = function(req, res){
	
	models = [];
	request(givenUrl, function(error, response, html){
			if(!error && response.statusCode == 200){

				var $ = cheerio.load(html);
				
				

				$('#search-wrap').children('div.search-section-wrap').eq(1).children('div.search-para-wrap').eq(0).children('a').each(function(i, element){

					var cur = $(this).text().trim().split("(");
					
					var car = cur[0].trim();
					var num = cur[1].trim().split(")");
					var n = num[0].trim();

					models.push({"name": car, "number": n});
					// console.log(car + "|" + n + "|");
				});

				// for(var i = 0; i < models.length; i++)
				// {
				// 	console.log(models[i]);
				// }

				res.send(models);
			}
		});
}