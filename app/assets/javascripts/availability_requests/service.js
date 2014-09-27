angular.module('availability_requests.services', [ ]).
  factory('availabilityRequestsService', ['Restangular', function(Restangular){

    var service = {
      base: Restangular.all('availability_requests'),

      all: [],

      getList: function(params){
        return service.base.getList(params).then(function(results) {
          service.all = results;
        });
      },

      post: function() {
        return service.base.post({
          location_id: service.location.originalObject.id,
          date_start: service.date_start,
          date_end: service.date_end,
          days_length: service.days_length
        }).then( function(result) {
          service.all.push(result);
          service.location = null;
          service.date_start = null;
          service.date_end = null;
        });
      },

      put: function(item) {
        return item.put().then(function(results) {

        });
      }

    };

    return service;

  }]);
