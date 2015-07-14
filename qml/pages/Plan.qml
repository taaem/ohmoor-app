import QtQuick 2.4
import QtQuick.Controls 1.3
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1
import QtQuick.Layouts 1.1

import com.taaem.vertretungsplan 1.0

Page{
    property bool loading
    property string dateHref
    property string dateTitle
    property bool reload
    property ListModel msgModel: ListModel{}

    id: page
    title: dateTitle
    actionBar.maxActionCount: 1
    actions: [
        Action {
            iconName: "navigation/refresh"
            name: "Neu Laden"
            enabled: true
            onTriggered: {
                reload = true
            }
        },
        Action {
            iconName: "action/settings"
            name: "Einstellungen"
            onTriggered: pageStack.push(Qt.resolvedUrl("Settings.qml"))
        }

    ]


    ProgressCircle{
        id: mainCircle
        anchors.centerIn: parent
        color: Theme.accentColor
        visible: loading ? true : false
    }

    Scrollbar{
        flickableItem: mainList
    }

    ListView{
        anchors.fill: parent
        id: mainList
        clip: true

        header: Item{
            height: childrenRect.height + Units.dp(20)
            width: parent.width
            Card{
            height: col.height + Units.dp(20)
            //anchors.topMargin: 100
            width: parent.width/1.5
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                id: col
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Units.dp(20)
                Repeater{
                    id: repeaterHeader
                    model: msgModel
                    Label{
                        text: modelData;
                        wrapMode: Text.Wrap
                        font.pixelSize: Units.dp(15)
                    }
                }
            }
        }
        }

        model: ListModel{}
        spacing: Units.dp(5)
        delegate:Card{
            height: column.height + Units.dp(20)
            //anchors.topMargin: 100
            width: parent.width/1.5
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                id: column
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Units.dp(20)
                property int fontSize: 15
                property string fontFamily: ""
                Label{
                    text: "<b>Klasse:</b> " + klasse;
                    font.pixelSize: Units.dp(parent.fontSize)
                }

                Label{
                    text: "<b>Stunde:</b> " + stunde;
                    font.pixelSize: Units.dp(parent.fontSize)
                }

                Label{
                    text: "<b>Vertreter:</b> " + vertreter;
                    font.pixelSize: Units.dp(parent.fontSize)
                }
                Label{
                    text: "<b>Fach:</b> " + fach;
                    font.pixelSize: Units.dp(parent.fontSize)
                }

                Label{
                    text: "<b>Lehrer:</b> " + lehrer;
                    font.pixelSize: Units.dp(parent.fontSize)
                }

                Label{
                    text: "<b>Raum:</b> " + raum;
                    font.pixelSize: Units.dp(parent.fontSize)
                }
            }
            ListItem.Divider{}
        }
    }
    Vertretungsplan{
        id: plan
        onPlanReceived:{
            mainList.model.append(item)
            page.loading = false
        }
        onLoadingPlan:{
            page.loading = true
        }
        onGotPlanDate: {
            page.dateTitle = date;
        }
        onGotMsg: {
            page.msgModel.clear();
            for(var i in msg){
                page.msgModel.append({ modelData: msg[i]})
            }
        }
    }


    onDateHrefChanged: {
        reload = true
    }
    onReloadChanged:{
       if(reload === true){
           mainList.model.clear()
           plan.getPlan(dateHref + settingStorage.klasse + settingStorage.letter)
           reload = false
       }
   }
}
