angular.module('availability_requests.services', [ ]).
  factory('availabilityRequestsService', ['$q', function( $q){

    var service = {
      all: function(params){
        return Restangular.all('availability_requests').getList(params);
      }
    };

    return service;

  }]);
