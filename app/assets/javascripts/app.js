angular.module('wl_availability', [
  'ui.router',
  'wl_a.availability_requests'
])
.config(['$httpProvider', function($httpProvider){
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}])
.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', function($stateProvider, $urlRouterProvider, $locationProvider) {

  //$urlRouterProvider.otherwise('/');
  // $locationProvider.html5Mode(true);
  // $locationProvider.hashPrefix('!');

  $stateProvider
    .state('availabilityRequests',{
      url: '',
      views: {
        'availability_request_new': {
          templateUrl: '/assets/availability_requests/new.html',
          controller: 'AvailabilityRequestController'
        },
        'availability_request_list': {
          templateUrl: '/assets/availability_requests/index.html',
          controller: 'AvailabilityRequestsController'
        }

      }
    });


}]);
