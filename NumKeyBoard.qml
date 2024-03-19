import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import FluentUI

Rectangle{
    id: d
    x:0
    y:0
    property int hoverrow: -1
    property color cellBorderColor: "#375278"
    property color rowHoverColor: "blue"
    property color rowSelectColor: "red"
    property color cellEditBackgroundColor: "white"
    property color cellEditForgegroundColor: "#375278"
    property var columnBackgroundColor: [Qt.rgba(55/255,82/255,120/255,0.08), "white", "white", "white"]
    property var columnForgeroundColor: ["#375278", "#375278", "#375278", "#375278"]

    MouseArea{
        anchors.fill: parent
        onPressed: function(mouse){
            mouse.accepted = true
            console.log("input pane pressed")
        }
        onReleased: function(mouse){
            mouse.accepted = true
            console.log("input pane released")
        }
        onClicked: function(mouse){
            mouse.accepted = true
            console.log("input pane clicked")
        }
    }
    z: 100
    ListModel{
        id:list_model
        Component.onCompleted: {
            var vvs = ["7", "88", "9", "X", "4", "5", "6", "Del", "1", "2", "3", "Enter", "0", "."]
            for(var i=0;i< vvs.length; i++){
                var item = {}
                item.color = "yellow"
                item.height = 32
                item.width = 32
                item.display = vvs[i]
                append(item)
            }
        }
    }
    TextInput{
        id: txt

        visible: false
        horizontalAlignment:  Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: d.cellEditForgegroundColor
        z: 1000
    }
    GridLayout {
        id: cc
        anchors.fill: parent
        columns: 4// d.columnForgeroundColor.length
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        columnSpacing: 2
        rowSpacing: 2
        property int editCell: -1
        Repeater{
            model: list_model
            delegate: Rectangle {
                z: 101
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.columnSpan: {
                    if(index==12)
                        return 2
                    return 1;
                }
                Layout.rowSpan: {
                    console.log("index=%1".arg(index))
                    if(index==11){

                        return 2
                    }
                    return 1
                }
                Rectangle {
                    id: rectContent
                    radius: 1
                    anchors.fill: parent
                    color: d.hoverrow === Math.floor(index/cc.columns) ? d.rowHoverColor : d.columnBackgroundColor[index%cc.columns]

                    visible: cc.editCell !== index
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            d.hoverrow = Math.floor(index/cc.columns)
                        }
                        onExited: {
                            d.hoverrow = -1
                        }
                        onMouseXChanged: {
                            d.hoverrow = Math.floor(index/cc.columns)
                        }
                        onMouseYChanged: {
                            d.hoverrow = Math.floor(index/cc.columns)
                        }

                        onPressed: function(mouse){
                            mouse.accepted = true
                            console.log("press clicked")
                            txt.visible = false
                            if(cc.editCell !== -1){
                                list_model.setProperty(cc.editCell, "display", txt.text)
                                //model.display = txt.text
                            }

                            cc.editCell = -1

                        }
                        onReleased: function(mouse){
                            mouse.accepted = true
                        }

                        onDoubleClicked: function(mouse){
                            console.log("double click")
                            txt.text = model.display
                            var curPos = lablex.mapToItem(d, 0, 0)
                            console.log("current cell pos=%1".arg(JSON.stringify(curPos)))
                            txt.x = curPos.x
                            txt.y = curPos.y
                            txt.width = lablex.width
                            txt.height = lablex.height
                            txt.color = d.cellEditForgegroundColor
                            txt.visible = true
                            txt.forceActiveFocus()
                            cc.editCell = index

                        }

                        onClicked: function(mouse){

                        }
                    }
                }
                Label{
                    id: lablex
                    anchors.centerIn: parent
                    text: model.display
                    visible: cc.editCell !== index
                    color: d.columnForgeroundColor[index% cc.columns]
                    leftPadding: 2
                    rightPadding: 2
                }

            }
        }
    }
}
