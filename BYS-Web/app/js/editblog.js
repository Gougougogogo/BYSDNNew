angular.module('app.blog').controller('editBlogController', ['$scope', '$http', '$state', '$stateParams', '$timeout', '$cacheFactory', function ($scope, $http, $state, $stateParams, $timeout, $cacheFactory) {

    var $httpDefaultCache = $cacheFactory.get('$http');

    var common = {};

    common.htmlEncode = function (str) {
        var s = "";
        if (str.length == 0) return "";
        s = str.replace(/&/g, "&namp;");
        s = s.replace(/</g, "&nlt;");
        s = s.replace(/>/g, "&ngt;");
        //s = s.replace(/ /g, "&nbsp;");
        //s = s.replace(/\'/g, "&#39;");
        s = s.replace(/\"/g, "&nquot;");
        return s;
    };

    common.htmlDecode = function (str) {
        var s = "";
        if (str.length == 0) return "";
        s = str.replace(/&namp;/g, "&");
        s = s.replace(/&nlt;/g, "<");
        s = s.replace(/&ngt;/g, ">");
        //s = s.replace(/&nbsp;/g, " ");
        //s = s.replace(/'/g, "\'");
        s = s.replace(/&nquot;/g, "\"");
        //s = s.replace(/<br>/g, "\n");
        return s;
    };

    $scope.bolgId = $stateParams.blogId;

    $timeout(function () {
        if ($scope.bolgId != undefined) {
            var load = layer.load(0);
            initTinymce();
            $http.get('../Blog/GetBlogContent', {
                params: {
                    blogId: $scope.bolgId
                }
            })
            .success(function (e) {
                $scope.blogContent = e.retData;
                $timeout(function () {
                    tinymce.activeEditor.setContent($scope.blogContent.Content);
                }, 300);
            }).error(function (e) {

            }).finally(function () {
                layer.close(load);
            });
        }
    }, 100);

    $scope.publish = function () {
        var content = tinymce.activeEditor.getContent();
        var requestData = {
            title: $scope.blogContent.Title,
            blogId: $scope.bolgId,
            blogContent: common.htmlEncode(content),
        };
        var loader = layer.load(0);
        $.ajax({
            url: "../Blog/RequestEdit",
            type: 'POST',
            data: requestData,
            success: function (e) {
                layer.close(loader);
                if (e.success) {
                    layer.msg('edit successfully!');
                    $state.go('app.blog.detail', { blogTypeId: e.itemId });                    
                }
                else {
                    layer.msg(e.errorMessage);
                }
            },
            error: function (e) {
                layer.msg(e.retData);
                layer.close(loader);
            }
        });
    };

    function initTinymce() {
        tinymce.init({
            selector: "textarea",

            theme: "modern",

            thieme_url: "/themes/modern/theme.min.js",

            plugins: 'link image code codesample table textcolor emoticons colorpicker autolink advlist lists charmap print preview  fullscreen hr anchor pagebreak spellchecker wordcount',

            external_plugins: {

            },

            add_unload_trigger: false,

            toolbar: "insertfile undo redo |styleselect fontsizeselect bold italic size | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons table codesample",

            height: "500px",

            image_advtab: true,

            image_caption: true,

            relative_urls: false,

            style_formats: [
                { title: 'Bold text', format: 'h1' },
                { title: 'Red text', inline: 'span', styles: { color: '#ff0000' } },
                { title: 'Red header', block: 'h1', styles: { color: '#ff0000' } },
                { title: 'Example 1', inline: 'span', classes: 'example1' },
                { title: 'Example 2', inline: 'span', classes: 'example2' },
                { title: 'Table styles' },
                { title: 'Table row 1', selector: 'tr', classes: 'tablerow1' }
            ],
            menu: {

            },
            skin: "custom",

            templates: [
                { title: 'Some title 1', description: 'Some desc 1', content: '<strong class="red">My content: {$username}</strong>' },
                { title: 'Some title 2', description: 'Some desc 2', url: 'development.html' }
            ],

            fontsize_formats: "8pt 9pt 10pt 11pt 12pt 26pt 36pt",

            setup: function (ed) {

            },

            spellchecker_callback: function (method, data, success) {
                if (method == "spellcheck") {
                    var words = data.match(this.getWordCharPattern());
                    var suggestions = {};

                    for (var i = 0; i < words.length; i++) {
                        suggestions[words[i]] = ["First", "second"];
                    }

                    success({ words: suggestions, dictionary: true });
                }

                if (method == "addToDictionary") {
                    success();
                }
            }
        });
    };
}]);