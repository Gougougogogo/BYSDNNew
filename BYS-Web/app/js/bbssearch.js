angular.module('app.bbs').controller('bbsSearchController',['$scope', '$http', '$stateParams', function ($scope, $http, $stateParams) {
    $scope.keyword = $stateParams.keyword;

    $scope.searchResult = [];

    $scope.search = function () {
        if ($scope.searchPattern != '') {
            $scope.keyword = $scope.searchPattern;
        }
    };

    $scope.$watch('keyword', function (newVal) {
        if (newVal != undefined && newVal != null) {
            if (newVal == '') {
                $scope.searchResult = [];
                return;
            }
            $http.get('../BBS/GetSearchResult', {
                cache : false,
                params: {
                    keyword: newVal
                }
            }).success(function (e) {
                if (e.success) {
                    $scope.searchResult = e.retData;
                }
            }).error(function (e) {
                layer.msg(e.retData);
            });
        }
    });
}]).filter(
'to_trusted', ['$sce', function ($sce) {
    return function (text) {
        return $sce.trustAsHtml(text);
    }
}]);