var app = angular.module('myApp', ['ngRoute','myApp.services','myApp.controllers']).
    config(['$routeProvider', function($routeProvider){
        $routeProvider.when('/', {templateUrl: 'partials/bookmark-list', controller: 'BookmarkListCtrl'});
        $routeProvider.when('/bookmark-detail/:id', {templateUrl: 'partials/bookmark-detail', controller: 'BookmarkDetailCtrl'});
        $routeProvider.otherwise({redirectTo: '/'});
}]);

