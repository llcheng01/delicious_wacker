'use strict';

/* Services */

var services = angular.module('myApp.services', ['ngResource']);

services.factory('BookmarksFactory', ['$resource',
    function($resource) {
        return $resource('/api/bookmarks', {}, {
            query: { method:'GET', isArray: true}
        });
}]);

services.factory('BookmarkFactory', ['$resource',
    function($resource) {
        return $resource('/api/bookmarks/:id', {}, {
            show: {method: 'GET'},
            update: {method: 'PUT', params: {id: '@id'}},
            delete: {method: 'DELETE', params: {id: '@id'}}
        });

}]);
