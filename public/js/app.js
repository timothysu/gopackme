(function () {
	'use strict';

	var byId = function (id) { return document.getElementById(id); },

		loadScripts = function (desc, callback) {
			var deps = [], key, idx = 0;

			for (key in desc) {
				deps.push(key);
			}

			(function _next() {
				var pid,
					name = deps[idx],
					script = document.createElement('script');

				script.type = 'text/javascript';
				script.src = desc[deps[idx]];

				pid = setInterval(function () {
					if (window[name]) {
						clearTimeout(pid);

						deps[idx++] = window[name];

						if (deps[idx]) {
							_next();
						} else {
							callback.apply(null, deps);
						}
					}
				}, 30);

				document.getElementsByTagName('head')[0].appendChild(script);
			})()
		},

		console = window.console;


	if (!console.log) {
		console.log = function () {
			alert([].join.apply(arguments, ' '));
		};
	}

	// Angular example
	angular.module('todoApp', ['ng-sortable'])
		.controller('TodoController', ['$scope', '$rootScope', function ($scope, $rootScope) {

			$scope.anymessage='';
			$scope.todos = [
				{text: 'Follow our instructions!', done: false},
				{text: 'Drag and drop as you wish.  Try it!', done: false},
				{text: 'Enjoy!', done: false}
			];

			$rootScope.$on('newtodos', function(event, obje) {
				$scope.todos = [];
				for (var index = 0; index < obje.length; ++index) {
					$scope.todos.push({"text":obje[index],"done": false});
				}
				console.log($scope.todos);
				//console.log(obje);
				$scope.$apply();
			});

			$rootScope.$on('newmessage', function(event, obje) {
				$scope.anymessage = '';
				if(typeof obje == 'string' || obje instanceof String) {
					$scope.anymessage = obje;
			  }
				else {
					for (var index = 0; index < obje.length; ++index) {
    				$scope.anymessage = $scope.anymessage + obje[index] + "\n";
					}
				}
				//console.log(obje);
				$scope.$apply();
			});

			$scope.addTodo = function () {
				$scope.todos.push({text: $scope.todoText, done: false});
				$scope.todoText = '';
			};

			$scope.remaining = function () {
				var count = 0;
				angular.forEach($scope.todos, function (todo) {
					count += todo.done ? 0 : 1;
				});
				return count;
			};

			$scope.message = function() {
				return $scope.anymessage;
			};

			$scope.archive = function () {
				var oldTodos = $scope.todos;
				$scope.todos = [];
				angular.forEach(oldTodos, function (todo) {
					if (!todo.done) $scope.todos.push(todo);
				});
			};
		}])
		.controller('TodoControllerNext', ['$scope', '$rootScope', function ($scope, $rootScope) {
			$scope.todos = [
				{text: 'Bovine', done: true},
				{text: 'These will be gone after we hear about your trip!', done: false}
			];

			$rootScope.$on('newalttodos', function(event, obje) {
				$scope.todos = [];
				//$scope.todos.push(angular.toJson({text:'Bovine', done:true}));
				for (var index = 0; index < obje.length; ++index) {
					$scope.todos.push({"text":obje[index],"done":false});
				}
				//$scope.todos.replace(/['"]+/g, '');
				//console.log(obje);
			  //console.log(angular.fromJson($scope.todos));
				$scope.$apply();
			});

			$scope.remaining = function () {
				var count = 0;
				angular.forEach($scope.todos, function (todo) {
					count += todo.done ? 0 : 1;
				});
				return count;
			};

			$scope.sortableConfig = { group: 'todo', animation: 150 };
			'Start End Add Update Remove Sort'.split(' ').forEach(function (name) {
				$scope.sortableConfig['on' + name] = console.log.bind(console, name);
			});
		}]).controller('InputController',
		['$scope', '$rootScope', function ($scope, $rootScope) {
				$scope.updateData = function () {
					console.log("Update clicked!");
					var $http = angular.injector(['ng']).get('$http');
					$http.post('http://gopackme.com/request',{city:$scope.city,state:$scope.state,tags:$scope.tags}).
						success(function(data, status, headers, config){
							$scope.anymessage = data['messages'];
							$scope.newtodos = data['titems'];
							$scope.alttodos = data['sitems'];
							$rootScope.$emit('newmessage', $scope.anymessage);
							$rootScope.$emit('newtodos', $scope.newtodos);
							$rootScope.$emit('newalttodos', $scope.alttodos);
						  console.log(data);
							console.log('Emitted!');
							//angular.element(document.getElementById('TodoController')).scope().setTitems(newtodos);
							//angular.element(document.getElementById('TodoController')).scope().updateMessage(anymessage[0]);
							//angular.element(document.getElementById('TodoControllerNext')).scope().setSitems(alttodos);
						}).error(function(data, status, headers, config){console.log("Error!")});

				};
		}]);
})();



// Background
document.addEventListener("DOMContentLoaded", function () {
	function setNoiseBackground(el, width, height, opacity) {
		var canvas = document.createElement("canvas");
		var context = canvas.getContext("2d");

		canvas.width = width;
		canvas.height = height;

		for (var i = 0; i < width; i++) {
			for (var j = 0; j < height; j++) {
				var val = Math.floor(Math.random() * 255);
				context.fillStyle = "rgba(" + val + "," + val + "," + val + "," + opacity + ")";
				context.fillRect(i, j, 1, 1);
			}
		}

		el.style.background = "url(" + canvas.toDataURL("image/png") + ")";
	}

	setNoiseBackground(document.getElementsByTagName('body')[0], 50, 50, 0.02);
	}, false);
