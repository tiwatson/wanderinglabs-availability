angular.module('availability_requests.controllers', [])

  .controller('AvailabilityRequestController', ['$scope', '$state', 'availabilityRequestsService', function($scope, $state, availabilityRequestsService) {
    $scope.ar = availabilityRequestsService;

    $scope.newRequest = function() {
      availabilityRequestsService.post();
    };

  }])

  .controller('AvailabilityRequestsController', ['$scope', '$state', 'availabilityRequestsService', function($scope, $state, availabilityRequestsService) {
    $scope.ar = availabilityRequestsService;
    $scope.predicate = '[-active, -date_start]';

    availabilityRequestsService.getList();

    $scope.pauseRequest = function(item) {
      item.active = !item.active;
      availabilityRequestsService.put(item);
    };

  }]);
