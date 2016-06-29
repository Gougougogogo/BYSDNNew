angular.module('app.blog').controller('blogDetailController', ['$scope', '$http', '$uibModal', '$state', '$stateParams', '$rootScope', function ($scope, $http, $uibModal, $state, $stateParams, $rootScope) {
    $scope.ItemId = $stateParams.blogTypeId;
    $scope.Items = 0;
    $scope.currentPage = 1;
    $scope.itemCountPerPage = 10;
    $scope.blogItems = [];
    $scope.topItems = [];
    $scope.app = $rootScope.app;

    $scope.isManager = $scope.app.managedBlog.indexOf($scope.ItemId) >= 0 ? true : false;

    $scope.publishNew = function () {
        $state.go('app.blog.newpost', { blogTypeId: $stateParams.blogTypeId });
    };

    $scope.getBlogItems = function () {
        getBlogItems();
    }

    function getBlogPage () {
        $http.get('../Blog/GetItemsCount', {
            params: {
                itemId: $stateParams.blogTypeId
            }
        }).success(function (e) {
            if (e.success) {
                $scope.Items = e.retData;
            }
        });
    };

    function getBlogItems() {
        $.ajax({
            url: "../Blog/GetItems",
            method: 'Get',
            dataType: 'json',
            cache: false,
            data: {
                itemId: $stateParams.blogTypeId,
                page: $scope.currentPage
            },
            success: function (e) {
                if (e.success) {
                    $scope.blogItems = [];
                    $scope.topItems = [];
                    var items = e.retData;
                    for (var i = 0; i < items.length; i++) {
                        if (items[i].Status == 1) {
                            $scope.blogItems.push(items[i]);
                        }
                        else
                        {
                            $scope.topItems.push(items[i]);
                        }
                    }
                    $scope.$apply();
                }
            },
            error: function (e) {
                layer.msg(e.retData);
            }
        });
    }

    getBlogPage();
    getBlogItems();

    $scope.openDetail = function (item) {
        $uibModal.open({
            animation: true,
            templateUrl: 'app/views/blog-detail.tpl.html',
            controller: 'blogDetailDialogController',
            // position via css class
            windowClass: 'modal-right modal-auto-size',
            backdropClass: '',
            // sent data to the modal instance (injectable into controller)
            resolve: {
                data: function () {
                    return {
                        blogId: item.BlogId
                    };
                }
            }
        }).result.then(function (retData) {
            // use data from modal here
            if (retData.type != undefined && retData.type == 'delete') {
                $state.reload();
            }

            if (retData.type != undefined && retData.type == 'edit') {
                $state.go('app.blog.edit', { blogId:retData.id });
            }
        }, function () {
            // Modal dismissed
        });
    };

    $scope.setStatus = function (blog, status) {
        var loader = layer.load(0);
        $http.post('../Blog/SetBlogStatus', { blogId: blog.BlogId, status: status }).then(
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
}]);

angular.module('app.blog').controller('blogDetailDialogController', ['$uibModalInstance', 'data', '$http', '$scope','$state' ,'$timeout', '$rootScope', function ($uibModalInstance, data, $http, $scope,$state, $timeout, $rootScope) {

    $scope.blogContent;
    $scope.showAttachments = false;
    $scope.attachments;
    $scope.ownUserName = $rootScope.app.userName;
    $scope.ownUserImg = $rootScope.app.userImg;

    function hightLight() {
        $('pre code').each(function (i, block) {
            hljs.highlightBlock(block);
        });
    }

    function getContent() {
        $http.get('../Blog/GetBlogContent', {
            params: {
                blogId: data.blogId
            }
        })
        .success(function (e) {
            $scope.blogContent = e.retData;
            $timeout(function () {
                hightLight();
            }, 100);
        });
    }

    function getAttachments() {
        $http.get('../Blog/GetAttachments', {
            cache: false,
            params: {
                Id: data.blogId
            }
        }).success(function (e) {
            if (e.success) {
                if (e.retData.length > 0) {
                    $scope.showAttachments = true;
                    $scope.attachments = e.retData;
                }
            }
        }).error(function (e) {
            layer.msg(e.retData);
        });
    }

    function getBlogReply() {
        $http.get('../Blog/GetBlogReplys', {
            params: {
                id: data.blogId,
                Page : 1
            }
        }).success(function (data) {
            if(data.success){
                $scope.replyList = data.retData;
                for (var i = 0; i < $scope.replyList.length; i++) {
                    $scope.replyList[i].IsCollapsed = true;
                }
            }
        });
    }

    getBlogReply();

    getAttachments();

    getContent();
    
    $scope.edit = function () {
        $uibModalInstance.close({
            type: 'edit',
            id: data.blogId
        });
    };

    $scope.delete = function () {
        $http.get('../Blog/DeleteBlog', {
            params: {
                blogId: data.blogId
            }
        }).success(function (data) {
            if (data.success) {
                layer.msg('delete successfully');
                $uibModalInstance.close({
                    type : 'delete'
                });
            }
            else
            {
                layer.msg(data.errorMessage);
            }
        });
    };

    $scope.replyOther = function (item) {
        item.IsCollapsed = !item.IsCollapsed;
    }

    $scope.requestReplyOther = function (item) {
        var req = {
            ReplyId: item.Id,
            content: item.newReplyContent
        };

        $http.post('../Blog/SubmitOtherReply', req).then(function (data) {
            if (data.data.success) {
                item.SubReply.push({
                    ReplyContent: item.newReplyContent, UserEmail: $scope.ownUserName + '@Microsoft.com',
                    UserImg: $scope.ownUserImg, UserName: $scope.ownUserName 
                });
                item.newReplyContent = '';
                item.IsCollapsed = true;
            };
        },
        function (data) {
            var b = data;
        });
    }

    $scope.getFileName = function (inputs) {
        var index = inputs.indexOf("%%");
        var result = '';
        if (index != -1) {
            for (var i = index + 2; i < inputs.length; i++) {
                result += inputs[i];
            }
        }
        return result;
    };

    $scope.replyOwner = function () {
        var req = {
            id: data.blogId,
            content: $('#reply').val()
        }

        $http.post('../Blog/SubmitReply', req).then(function (data) {
            if (data.data.success) {
                $scope.replyList.push({
                    Id: data.data.retData, ReplyContent: $('#reply').val(), UserEmail: $scope.ownUserName + '@Microsoft.com',
                    UserImg: $scope.ownUserImg, UserName: $scope.ownUserName, SubReply : [], IsCollapsed : true,newReplyContent : ''
                });
                $('#reply').val('');
            }
        },
        function (data) {
            var b = data;
        });
    };

    $scope.replyList = [];

    $scope.close = function () {
        $uibModalInstance.dismiss();
    };
}]).filter(
'to_trusted', ['$sce', function ($sce) {
    return function (text) {
        return $sce.trustAsHtml(text);
    }
}]);