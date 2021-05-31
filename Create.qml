import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

Item {
    id: root
    property string backBtnText: "<"
    property string title: "Создание игры"
    property int firstStep: 1
    property int fieldSize: 3
    property int lineToWin: 3
    property bool multipleLines: false

    anchors.fill: parent

    ColumnLayout {
        Layout.leftMargin: 16
        Layout.bottomMargin: 16
        width: parent.width

        Text {
            text: 'Какой игрок ходит первым?'
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.bottomMargin: 16
            Layout.rightMargin: 16
            columns: 3
            Button {
                text: "Первый игрок (X)"
                highlighted: firstStep == 1
                onClicked: {
                    firstStep = 1
                }
                leftPadding: 8
            }

            Button {
                text: "Второй игрок (O)"
                highlighted: firstStep == 2
                onClicked: {
                    firstStep = 2
                }
                leftPadding: 8
            }

            Button {
                text: "Случайно"
                highlighted: firstStep == 3
                onClicked: {
                    firstStep = 3
                }
                leftPadding: 8
            }

        }

        Text {
            text: "Размер игрового поля:"
        }

        GridLayout {
            columns: 9
            Layout.bottomMargin: 16
            Layout.rightMargin: 16
            Layout.alignment: horizontalCenter
            Layout.fillWidth: true

            Button {
                text: "3"
                highlighted: fieldSize == 3
                onClicked: {
                    fieldSize = 3
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "4"
                highlighted: fieldSize == 4
                onClicked: {
                    fieldSize = 4
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "5"
                highlighted: fieldSize == 5
                onClicked: {
                    fieldSize = 5
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "6"
                highlighted: fieldSize == 6
                onClicked: {
                    fieldSize = 6
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "7"
                highlighted: fieldSize == 7
                onClicked: {
                    fieldSize = 7
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "8"
                highlighted: fieldSize == 8
                onClicked: {
                    fieldSize = 8
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "9"
                highlighted: fieldSize == 9
                onClicked: {
                    fieldSize = 9
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "10"
                highlighted: fieldSize == 10
                onClicked: {
                    fieldSize = 10
                }
                Layout.preferredWidth: 50
            }

        }

        Text {
            text: "Размер линии:"
        }

        GridLayout {
            columns: 10
            Layout.bottomMargin: 16
            Layout.rightMargin: 16
            Layout.alignment: horizontalCenter
            Layout.fillWidth: true

            Button {
                text: "2"
                highlighted: lineToWin == 2
                visible: fieldSize >= 2
                onClicked: {
                    lineToWin = 2
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "3"
                highlighted: lineToWin == 3
                visible: fieldSize >= 3
                onClicked: {
                    lineToWin = 3
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "4"
                highlighted: lineToWin == 4
                visible: fieldSize >= 4
                onClicked: {
                    lineToWin = 4
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "5"
                highlighted: lineToWin == 5
                visible: fieldSize >= 5
                onClicked: {
                    lineToWin = 5
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "6"
                highlighted: lineToWin == 6
                visible: fieldSize >= 6
                onClicked: {
                    lineToWin = 6
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "7"
                highlighted: lineToWin == 7
                visible: fieldSize >= 7
                onClicked: {
                    lineToWin = 7
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "8"
                highlighted: lineToWin == 8
                visible: fieldSize >= 8
                onClicked: {
                    lineToWin = 8
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "9"
                highlighted: lineToWin == 9
                visible: fieldSize >= 9
                onClicked: {
                    lineToWin = 9
                }
                Layout.preferredWidth: 50
            }

            Button {
                text: "10"
                highlighted: lineToWin == 10
                visible: fieldSize >= 10
                onClicked: {
                    lineToWin = 10
                }
                Layout.preferredWidth: 50
            }

        }

        Text {
            text: "Условие победы:"

        }

        GridLayout {
            Layout.fillWidth: true
            Layout.bottomMargin: 16
            Layout.rightMargin: 16
            columns: 2
            Button {
                text: "Собрать линию первым"
                highlighted: !multipleLines
                onClicked: {
                    multipleLines = false
                }
                leftPadding: 8
            }

            Button {
                text: "Собрать как можно больше линий"
                highlighted: multipleLines
                onClicked: {
                    multipleLines = true
                }
                leftPadding: 8
            }

        }

        Button {
            text: "Создать игру"
            onClicked: onCreate({ "size": fieldSize, "first_step": firstStep, "line_to_win": lineToWin, "multiple_lines": multipleLines });
        }

    }


}
