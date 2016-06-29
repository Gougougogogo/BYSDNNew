angular.module('app.bbs').controller('bbsHomeController', ['$scope', '$http', '$state', '$stateParams', '$rootScope', function ($scope, $http, $state, $stateParams, $rootScope) {
    $scope.questions = [];

    $scope.currentPage = 1;
    $scope.pageCount = 1;
    $scope.itemperPage = 10;
    $scope.searchPatten = '';
    $scope.topItems = [];

    $scope.isManager = $scope.app.managedBBS.indexOf($stateParams.itemId) >= 0 ? true : false;

    function getBBSContent(page) {
        var load = layer.load(0);
        $http.get('../BBS/RequestQuestionList', {
            cache: false,
            params: {
                page: page,
                typeId: $stateParams.itemId
            }
        }).success(function (e) {
            if (e.success) {
                if (e.retData) {
                    $scope.topItems = [];
                    $scope.questions = [];
                    for (var i = 0; i < e.retData.length; i++) {
                        if (e.retData[i].Status > 1) {
                            $scope.topItems.push(e.retData[i]);
                        }
                        else
                        {
                            $scope.questions.push(e.retData[i]);
                        }
                    }
                }
                layer.close(load);
            }
        }).error(function (e) {
            layer.msg(e.retData);
            layer.close(load);
        });
    }
    
    $scope.init = function () {
        $http.get('../BBS/GetBBSQuestionPageCount', {
            cache :false,
            params: {
                pagecount: $scope.itemperPage,
                typeId: $stateParams.itemId
            }
        }).success(function (e) {
            if (e.success) {
                if (e.retData > 0) {
                    $scope.pageCount = e.retData;
                }
            }
        }).error(function (e) {
            layer.msg(e.retData);
        });

        getBBSContent(1);
    }

    $scope.init();

    $scope.setStatus = function (bbs, status) {
        var loader = layer.load(0);
        $http.post('../BBS/SetBBSStatus', { bbsID: bbs.BBSId, status: status }).then(
            function (success) {
                if (success) {
                    $state.reload();
                }
            },
            function (error) {
                layer.msg(error);
            }
        ).finally(function () {
            layer.close(loader);
        });
    };

    $scope.search = function () {
        $state.go('app.bbs.search', { keyword: $scope.searchPatten });
    };

    $scope.gotoDetail = function (id) {
        $state.go('app.bbs.detail', { bbsId: id });
    };

    $scope.quickReply = function (id) {
        layer.msg('function is on implementing.')
    };

    $scope.pageChanged = function () {
        getBBSContent($scope.currentPage);
    };
}]);