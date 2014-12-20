angular.module('wl_availability', [
  'ui.router',
  'restangular',
  'angucomplete-alt',
  'ngQuickDate',
  'wl_a.restangular_config',
  'wl_a.quickDatePickerDefaults',
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

        // route to show our basic form (/form)
        .state('form', {
            url: '/form',
            templateUrl: 'form.html',
            controller: 'formController'
        })

        // nested states
        // each of these sections will have their own view
        // url will be nested (/form/profile)
        .state('form.profile', {
            url: '/profile',
            templateUrl: 'form-profile.html'
        })

        // url will be /form/interests
        .state('form.interests', {
            url: '/interests',
            templateUrl: 'form-interests.html'
        })

        // url will be /form/payment
        .state('form.payment', {
            url: '/payment',
            templateUrl: 'form-payment.html'
        })  


    .state('availabilityRequests',{
      url: '',
      views: {
        'availability_request_new': {
          templateUrl: '/assets/availability_requests/new.html',
          controller: 'AvailabilityRequestController'
        }

      }
    });


}]);
