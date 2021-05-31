import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0


Item {
    property string title: "";
    property string error: "";
    property bool isLoading: false
    function onLogin() {
        console.log('login...');
    }

    function login(username, password, callback) {
        isLoading = true;
        const body = {
            username: username,
            password: password
        };
        fetchPost(baseURL + '/api/login', body, function(err, token) {
           isLoading = false;

           if (err) {
               error = err;
               return err;
           }

           callback(token);
        });
    }

    ColumnLayout {
        anchors {
            centerIn: parent
        }
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumHeight: 200
        Layout.minimumWidth: 200

        Label {
            text: "Добро пожаловать"
            Layout.alignment: Qt.AlignCenter
            font {
                pointSize: 18
                bold: true
            }

        }

        Item {
            height: 15
        }

        Label {
            text: "Никнейм"
        }

        TextField {
            id: _username_textField
            placeholderText: "Введите никнейм"
            selectByMouse: true
            Layout.fillWidth: true
        }

        Label {
            text: "Пароль"
        }

        TextField {
            id: _password_textField
            placeholderText: "Введите пароль"
            selectByMouse: true
            Layout.fillWidth: true
            echoMode: TextInput.PasswordEchoOnEdit
        }

        Item {
            id: _error_box
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            height: _error_text.contentHeight
            width: _error_text.contentWidth
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            visible: error.length > 0
            Text {
                id: _error_text
                text: qsTr(error)
                color: warningColor
            }
        }

        Button {
            text: "Войти"
            Layout.alignment: Qt.AlignCenter
            enabled: !isLoading
            Layout.topMargin: 30
            onClicked: {
                login(_username_textField.text, _password_textField.text, onLogin);
                error = ''
            }
        }



    }
}
