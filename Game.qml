import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0

Item {
    id: root
    property string title: "Игра №" + currentGameId

    function getUsernameFormatted(n, username) {
        var str = 'Игрок ' + n + ':';
        if (!username) username = '';
        if (username.length > 0) {
            str += ' ' + username;
        } else {
            str += ' ожидание...'
        }

        return str;
    }

    function updateField(field) {
        field_component.model.setField(field);
    }

    ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 5
        id: _column
        Rectangle {
            height: 30
            width: _firstUserText.contentWidth + 10
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            radius: 5
            border {
                color: "#666666"
                width: 1
            }
            Text {
                id: _firstUserText
                text: qsTr("Игрок 1: " + currentGame['first_player'])
                color: "#333333"
                font {
                    bold: true
                }
                anchors {
                    centerIn: parent
                }
            }
        }
        Rectangle {
            height: 30
            width: _secondUserText.contentWidth + 10
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 10
            radius: 5
            border {
                color: "#666666"
                width: 1
            }
            Text {
                id: _secondUserText
                text: qsTr(getUsernameFormatted(2, currentGame['second_player']))
                color: "#333333"
                font {
                    bold: true
                }
                anchors {
                    centerIn: parent
                }
            }
        }

        Rectangle {
            id: field_wrapper
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 10
            Field {
                id: field_component
                height: Math.min(field_wrapper.height, field_wrapper.width)
                width: Math.min(field_wrapper.height, field_wrapper.width)
                anchors {
                    centerIn: field_wrapper
                }
            }
        }

    }

}
