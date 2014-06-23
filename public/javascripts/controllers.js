'use strict';

var app = angular.module('myApp.controllers', []);

// Clear Browser cache (in dev)
app.run(function($rootScope, $templateCache){
    $rootScope.$on('$viewContentLoaded', function(){
        $templateCache.removeAll();
    });
});

app.controller('BookmarkListCtrl', ['$scope', 'BookmarksFactory', 'BookmarkFactory', '$location',
    function($scope, BookmarksFactory, BookmarkFactory, $location){
        $scope.editBookmark = function(url) {
            $location.path('/bookmark-detail/' + url);
        };

        $scope.bookmarks = BookmarksFactory.query();
    }
]);

app.controller('BookmarkDetailCtrl', ['$scope', '$routeParams', 'BookmarkFactory', '$location',
    function($scope, $routeParams, MovieFactory, $location) {
        // callback for ng-click 'updateMovie'
        $scope.updateBookmark = function() {
            BookmarkFactory.update($scope.bookmark);
            $location.path('partials/bookmark-list');
        };

        // callback for ng-click 'cancel'
        $scope.cancel = function(){
            $location.path('partials/bookmark-list');
        };
        $scope.bookmark = BookmarkFactory.show({id: $routeParams.id});
    }
]);
/*
app.controller('MovieCreateCtrl', ['$scope', 'MoviesFactory', '$location',
    function($scope, MoviesFactory, $location) {
        // callback for ng-click 'createMovie'
        $scope.createMovie = function() {
            MoviesFactory.create($scope.movie);
            $location.path('partials/movie-list');
        };

    }
]);
*/
