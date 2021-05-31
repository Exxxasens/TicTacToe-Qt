import QtQuick 2.0

Rectangle {
    id: root

    property string displayValue: "";

    border {
        color: "#666666"
        width: 1
    }
    Text {
        text: qsTr(displayValue)
        color: "#333333"
        anchors {
            centerIn: root
        }
        font {
            pointSize: Math.min(root.width, root.height)
            bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            handleClick(index);
        }
    }
}
