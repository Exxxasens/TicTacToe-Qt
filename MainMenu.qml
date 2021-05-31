import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

Item {
    property string backBtnText: ""
    property string title: "Игровое меню"
    property bool isShowGameIdInput: false

    function onLogout() {}
    function onJoin() {}
    function onCreate() {}

    Create {
        id: create_game_block
        visible: false
    }

    ColumnLayout {
        anchors {
            centerIn: parent
        }
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumHeight: 200
        Layout.minimumWidth: 200

        Text {
            text: 'Добро пожаловать' + ', ' + username;
            Layout.bottomMargin: 20
            font {
                pointSize: 18
            }
        }

        Button {
            text: "Создать игру"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            onClicked: {
                stack_view.push(create_game_block);
            }
        }

        Item {
            id: _error_create_game
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            height: _error_create_game.contentHeight
            width: _error_create_game.contentWidth
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            visible: gameCreateError.length > 0
            Text {
                id: _error_create_game_text
                text: qsTr(gameCreateError)
                color: warningColor
                anchors {
                    centerIn: parent
                }
            }
        }

        Button {
            text: "Присоединиться к игре"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            onClicked: {
                if (isShowGameIdInput) {
                    isShowGameIdInput = false;
                } else {
                    isShowGameIdInput = true;
                }
            }
        }

        Column {
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Layout.alignment: Qt.AlignCenter
            visible: isShowGameIdInput
            Row {
                TextField {
                    id: _game_id_input
                    placeholderText: "Введите номер игры"
                    selectByMouse: true
                    Layout.fillWidth: true
                }
                Button {
                    text: ">"
                    width: 40
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        onJoin(_game_id_input.text);
                    }
                }
            }
        }


        Button {
            text: "Выход"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            onClicked: {
                console.log('logout');
                onLogout();
            }
        }
    }

}

