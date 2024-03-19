import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "red"
    Rectangle{
        anchors.fill: parent
        color: "blue"
        border.width: 5
        border.color: "green"
        FluTable{
            anchors.centerIn: parent
            width: parent.width - parent.border.width * 2
            height: parent.height - parent.border.width * 2
            visible: true
            color: "lightgray"
        }
    }


}
