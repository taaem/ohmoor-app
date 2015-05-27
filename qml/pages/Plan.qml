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
    property string date

    id: page
    title: date
    actions: [
        Action {
            iconName: "navigation/refresh"
            name: "Refresh"
            enabled: true
            onTriggered: {
                reload()
            }
        },
        Action {
            iconName: "action/settings"
            name: "Settings"
            onTriggered: settings.show()

        }

    ]
    Dialog {
        id: settings
        title: "Einstellungen"
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            MenuField {
                id: klassenSelector
                //Layout.alignment: Qt.AlignVCenter
                model: ["Alle", "5", "6", "7", "8", "9", "10", "11", "12"]
                //selectedText: appWindow.klasse
                maxVisibleItems: 9
            }
            MenuField {
                id: letterSelector
                Layout.alignment: Qt.AlignVCenter
                model: ["Alle", "a", "b", "c", "d", "e", "f"]
                maxVisibleItems: 7
                //selectedText: appWindow.letter
            }
        }
        onAccepted: {
            if(klassenSelector.selectedText != "Alle") {
                settingStorage.klasse = "/" + klassenSelector.selectedText
            }else{
                settingStorage.klasse = ""
            }
            if(letterSelector.selectedText != "Alle"){
                 settingStorage.letter = "/" + letterSelector.selectedText
            }else{
                 settingStorage.letter = ""
            }
            reload()
        }
    }

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
        model: ListModel{}
        spacing: 10
        delegate:Card{
            height: Units.dp(150)
            //anchors.topMargin: 100
            width: parent.width/1.5
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
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
                    text: "<b>Vertreter</b> " + vertreter;
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
            page.date = date;
        }
    }


    onDateHrefChanged: {
        reload(appWindow)
    }

    function reload(){
        mainList.model.clear()
        plan.getPlan(dateHref + settingStorage.klasse + settingStorage.letter)
    }
}
