import QtQuick 2.0

Item {
    id: root
    width: 56; height: 56
//    x: 12; y: 12
    signal clicked
    property alias text: label.text
    Rectangle {
        anchors.fill: parent
        color: "#ea7025"
        border.color: Qt.lighter(color)
        gradient: "NightFade"
        radius: 50
        Text {
            id: label
            anchors.centerIn: parent
            text: qsTr("Show")
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: pressed ? Qt.ClosedHandCursor : Qt.PointingHandCursor
            onClicked: {
                root.clicked()
            }
        }
    }
}
