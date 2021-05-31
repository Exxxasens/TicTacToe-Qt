import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import Qt.WebSockets 1.0
import 'JWT.js' as JWT
import 'SSE.js' as SSE

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Крестики нолики")

    readonly property color warningColor: "#ff5858"
    readonly property color textColor: "#333333"
    property string token: ""
    property bool isUserAuthorized: false
    property string username: ""
    property string user_id: ""
    property string gameCreateError: ""
    property string currentGameId: ""
    property variant currentGame: ({})
    property variant eventSource: ({})
    property bool isTimerRun: false
    property string baseURL: 'http://localhost:5000'
    property bool show_config_game: false

    function popPage() {
         stack_view.pop()
    }

    function fetchPost(url, body, callback, useAuth) {
        const method = "POST";
        const xhr = new XMLHttpRequest();
        xhr.open(method, url);
        xhr.setRequestHeader("Content-Type", "application/json");
        if (useAuth) {
            xhr.setRequestHeader('Authorization', 'bearer ' + token);
        }
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status && xhr.status === 200) {
                    if (xhr.responseText) {
                        var result = JSON.parse(xhr.responseText);
                        if (result['error']) {
                            callback(result['result'], null);
                        } else {
                            callback(null, result['result']);
                        }
                    }
                } else {
                    callback(xhr.statusText, null);
                    console.log("HTTP:", xhr.status, xhr.statusText);
                }
            }
        }
        xhr.send(JSON.stringify(body));
    }

    header: ToolBar {
        height: 50
        ToolButton {
            id: button_back
            text: stack_view.currentItem.backBtnText || ""
            visible: stack_view.depth > 1 && stack_view.hasOwnProperty("backBtnText") && stack_view.currentItem.backBtnText
            anchors {
                verticalCenter: parent.verticalCenter
            }
            onClicked: {
                popPage();
            }
        }
        Text {
            anchors {
                centerIn: parent
            }
            font {
                pointSize: 20
            }
            color: textColor
            text: stack_view.currentItem.title ? stack_view.currentItem.title : ""
        }
    }

    StackView {
        id: stack_view
        initialItem: login_page
        anchors {
            centerIn: parent
            fill: parent
        }
    }

    Login {
        id: login_page
        title: "Авторизация"
        function onLogin(_token) {
            if (!_token) return null;
            stack_view.push(_main_menu);
            var payload = JWT.parse(_token);

            console.log(payload);

            username = payload['username'];
            user_id = payload['id'];
            token = _token;
            isUserAuthorized = true;

            console.log('stack view pop, testing...');
        }
    }


    MainMenu {
        id: _main_menu
        visible: false

        function onJoin(id) {
            currentGameId = id;
            console.log(id)
            const gameUrl = baseURL + '/api/game/' + id;

            fetchPost(gameUrl, {}, function(e, data) {

                console.log('trying to fetch data');

                if (e) {
                    console.log(error);
                }

                if (data) {
                    currentGame = data;

                    game.updateField(data['game_field']);

                    isTimerRun = true;

                    stack_view.push(game);

                }

            }, true);
        }

        function onCreate(config) {
            fetchPost(baseURL + '/api/game/create', config, function(err, result) {
                if (err) {
                    return gameCreateError = err;
                }

                onJoin(result);
            }, true);

        }

        function onLogout() {
            popPage();
            token = '';
        }
    }

    Game {
        id: game
        visible: false
    }

    Timer {
        interval: 500; running: currentGameId && currentGame && currentGame['status'] !== 'finished'; repeat: true
        onTriggered: {

            if (currentGame && currentGame['status'] !== 'finished') {

                const isNeedToFetchData = currentGame['first_player'] === username && currentGame['next_step'] === 2 || currentGame['second_player'] === username && currentGame['next_step'] === 1 || !currentGame['second_player']

                if (isNeedToFetchData) {
                    var URL = baseURL + '/api/game/' + currentGameId;
                    fetchPost(URL, null, function(err, data) {
                        console.log('fetch data');

                        if (err) {
                            console.log(err);
                        }

                        if (data) {
                            currentGame = data;
                            game.updateField(data['game_field']);
                        }

                    }, true);

                }

            } else {
                isTimerRun = false;
            }

        }
    }

}
