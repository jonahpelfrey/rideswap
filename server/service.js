var request = require('request');
var cheerio = require('cheerio');
var config = require('./config.js');
var Q = require('q');

module.exports = {

	getModelsForMake: function(givenUrl){

		request(givenUrl, function(error, response, html){
			if(!error && response.statusCode == 200){

				var $ = cheerio.load(html);
				
				models = [];

				$('#search-wrap').children('div.search-section-wrap').eq(1).children('div.search-para-wrap').eq(0).children('a').each(function(i, element){

					var cur = $(this).text().trim().split("(");
					
					var car = cur[0].trim();
					var num = cur[1].trim().split(")");
					var n = num[0].trim();

					models.push({"name": car, "number": n});
					// console.log(car + "|" + n + "|");
				});

				for(var i = 0; i < models.length; i++)
				{
					console.log(models[i]);
				}
			}
		});
	},

	getFullPageResults: function(givenUrl) {

		var p = Q.defer();

		request(givenUrl, function(error, response, html) {
			if(!error && response.statusCode == 200) {

				var $ = cheerio.load(html);

				var s = {};

				var leases = [];
				var promises = [];

				$('div.listing-row').each(function(i, element) {
					
					var d = {};

					//Details url
					d.detailUrl = $(this).attr('href');
					console.log(d.detailUrl);

					//Year, Make
					var info = $(this).find('.listing-info').children('.header3').text().trim().split(" ");
					d.year = info[0];
					d.make = info[1];

					//iterate through rest of info for model 
					var temp = "";
					for(var i = 2; i < info.length; i++) {

						if(i > 2) { temp = temp.concat(" "); }

						temp = temp.concat(info[i]);
					}

					//Model
					d.model = temp;
					console.log(d.model);

					//Number of available photos
					var c = $(this).find('.overlay-photos');
					if(c.length == 0) {

						d.numPhotos = 0;
						console.log(d.numPhotos);

					} else {
						
						c = c.text().trim();
						d.numPhotos = parseInt(c);
						console.log(d.numPhotos); 
					}

					//Drive Style
					d.driveStyle = $(this).find('.listing-info').children('b').eq(0).text();
					console.log(d.driveStyle);

					//Location
					d.location = $(this).find('.listing-info').children('b').eq(1).text();
					console.log(d.location);

					//Exterior color
					d.exteriorColor = $(this).find('.listing-info').children('b').eq(2).text();
					console.log(d.exteriorColor);

					//Interior color
					d.interiorColor = $(this).find('.listing-info').children('b').eq(3).text();
					console.log(d.interiorColor);

					//Miles per month
					d.milesPerMonth = $(this).find('.listing-info').children('b').eq(4).text();
					console.log(d.milesPerMonth);

					//Monthly payment
					var payment = $(this).find('li.payment').text();
					payment = payment.replace(/\s/g, "");
					d.payment = payment;
					console.log(d.payment);

					//Months remaining on lease
					var months = $(this).find('li.months').text();
					months = months.replace(/\s/g, "");
					d.monthsLeft = parseInt(months);
					console.log(d.monthsLeft);
					console.log('==============================');

					promises.push(getDetailsPage(d.detailUrl));
					leases.push(d);

				});

				Q.all(promises).then(function(results){
					for(var i = 0; i < results.length; i++){
						leases[i].owner = results[i];
						console.log(leases[i].milesPerMonth + " | " + results[i].milesPerMonth);
					}
					
					p.resolve(leases);
				});

			} else {
				p.reject(error);
			}
		});

		return p.promise;
	}
} //End of exports

//Helper Functions
function getDetailsPage(givenUrl){

	var detailUrl = config.BASE_URL + givenUrl;

	var p = Q.defer();

	request(detailUrl, function(error, response, html) {
		if(!error && response.statusCode == 200) {

			var $ = cheerio.load(html);

			var owner = {};

			//Get owner comments
			owner.comments = $('#comments').text().trim().replace(/\s+/, '\x01').split('\x01');
			console.log(owner.comments);

			//Owner id ref
			owner.contactUrl = $('div.link-button-inverse').children().attr('href');
			console.log(owner.contactUrl);
			
			$('#lease-details').children('div.row').each(function(i, element){
				var cr = $(this).children('div.label').text().trim();
				var dv = $(this).children('div.value').text().trim();

				if(cr == 'Current Miles') { owner.currentMiles = dv; }

				else if(cr == 'Remaining Miles') { owner.remainingMiles = dv; }

				else if(cr == 'Miles Per Month') { owner.milesPerMonth = dv; }

				else if(cr == 'Leasing Company') { owner.leasingCompany = dv; }

			})
			
			//Length of lease
			owner.loanTerm = $('#lease-details').children('div.row').eq(2).children('div.value').text().trim();
			console.log(owner.loanTerm);

			//SAL ID
			owner.salId = $('#details-misc').children('div.row').eq(1).children('div.value').text().trim();
			console.log(owner.salId);

			//VIN number
			owner.vin = $('#details-misc').children('div.row').eq(2).children('div.value').text().trim();
			console.log(owner.vin);

			//Owner location
			owner.location = $('#details-misc').children('div.row').eq(3).children('div.value').text().trim();

			p.resolve(owner);

		} else {
			p.reject(error);
		}
	});

	return p.promise;
}





function getYearsForModel(givenUrl){

	request(givenUrl, function(error, response, html){
		if(!error && response.statusCode == 200){

			var $ = cheerio.load(html);

			$('#search-wrap').children('div.search-section-wrap').eq(3).children('div.search-para-wrap').eq(0).children('a').each(function(i, element){

				var cur = $(this).text().trim().split("(");
				var year = cur[0].trim();
				console.log(year);
			});
		}
	});
}

function getTotalNumberPages(givenUrl){

	//grab url
	var p = Q.defer();

	request(givenUrl, function(error, response, html){
		if(!error && response.statusCode == 200){

			var $ = cheerio.load(html);

			pageNo = {};

			var tag = $('div.results-controls').text();
			tag = tag.trim();
			tag = tag.split(" ");

			var pages = tag[3];
			pages = pages.replace(/\s+/, '\x01').split('\x01');
			pages = pages[0];
		}

	});

}

function filterResultsForPendingOrSold(givenUrl){
	//Check img listing tag on small thumbnail on results page
}
