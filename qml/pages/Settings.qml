import QtQuick 2.4
import QtQuick.Controls 1.3
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Layouts 1.1
import com.taaem.vertretungsplan 1.0


Page {
    id: settings
    title: "Einstellungen"
    property bool hideKlasse
    Column{
        anchors.fill: parent
        spacing: Units.dp(10)

        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Units.dp(20)
            text: "Deine Klasse:"
        }

        ComboBox {
            anchors.horizontalCenter: parent.horizontalCenter
            id: klassenSelector
            //Layout.alignment: Qt.AlignVCenter
            model: ["Alle", "5", "6", "7", "8", "9", "10", "11", "12"]
            //selectedText: appWindow.klasse
            onCurrentIndexChanged: if(klassenSelector.currentIndex > 6){ settings.hideKlasse = true}else{ settings.hideKlasse = false}
        }

        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Units.dp(20)
            visible: !settings.hideKlasse
            text: "Dein Klassenbuchstabe:"
        }

        ComboBox {
            anchors.horizontalCenter: parent.horizontalCenter
            id: letterSelector
            visible: !settings.hideKlasse
            Layout.alignment: Qt.AlignVCenter
            model: ["Alle", "a", "b", "c", "d", "e", "f"]
            //selectedText: appWindow.letter
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            backgroundColor: theme.accentColor
            text: "Speichern"
            onClicked:{
                if(klassenSelector.model[klassenSelector.currentIndex] != "Alle" && klassenSelector.model[klassenSelector.currentIndex] != undefined) {
                    settingStorage.klasse = "/" + klassenSelector.model[klassenSelector.currentIndex]
                    console.log(klassenSelector.model[klassenSelector.currentIndex])
                }else{
                    settingStorage.klasse = ""
                }
                if(letterSelector.model[letterSelector.currentIndex] != "Alle" && letterSelector.model[letterSelector.currentIndex] != undefined && klassenSelector.model[klassenSelector.currentIndex] < 11) {
                     settingStorage.letter = "/" +letterSelector.model[letterSelector.currentIndex]
                }else{
                     settingStorage.letter = ""
                }
                console.log(letterSelector.model[letterSelector.currentIndex])
                var cur = pageStack.pop()
            }
        }
    }

    Component.onCompleted: {
        var lIndex = letterSelector.find(settingStorage.letter.split("/")[1])
        letterSelector.currentIndex = lIndex
        var kIndex = klassenSelector.find(settingStorage.klasse.split("/")[1])
        klassenSelector.currentIndex = kIndex
    }
}
