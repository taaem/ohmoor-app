import QtQuick 2.4
 import QtQuick.Controls 1.2 as QuickControls
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Layouts 1.1
import com.taaem.vertretungsplan 1.0


Page {
    id: settings
    title: "Einstellungen"
    property bool hideKlasse: false
    property string jahrgang
    property string klasse

    Dialog{
        id: jahrgangChooser
        title: "Ändere deinen Jahrgang"

        QuickControls.ExclusiveGroup{
            id: jahrgangGroup
        }
        RadioButton{
            text: "Alle"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "5"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "6"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "7"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "8"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "9"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "10"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "11"
            exclusiveGroup: jahrgangGroup
        }
        RadioButton{
            text: "12"
            exclusiveGroup: jahrgangGroup
        }
        onAccepted: {
            settings.jahrgang = jahrgangGroup.current.text

        }
    }
    Dialog{
        id: klassenChooser
        QuickControls.ExclusiveGroup{
            id: klassenGroup
        }
        RadioButton{
            text: "Alle"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "a"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "b"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "c"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "d"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "e"
            exclusiveGroup: klassenGroup
        }
        RadioButton{
            text: "f"
            exclusiveGroup: klassenGroup
        }
        onAccepted: {
            settings.klasse = klassenGroup.current.text

        }
    }

    Column{
        anchors.fill: parent
        spacing: Units.dp(10)
/*
        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Units.dp(20)
            text: "Deine Klasse:"
        }

        QuickControls.ComboBox {
            anchors.horizontalCenter: parent.horizontalCenter
            id: klassenSelector
            //Layout.alignment: Qt.AlignVCenter
            model: ["Alle", "5", "6", "7", "8", "9", "10", "11", "12"]
            //selectedText: appWindow.klasse
            onCurrentIndexChanged: if(klassenSelector.currentIndex > 6){ settings.hideKlasse = true}else{ settings.hideKlasse = false}
        }*/

        // TODO Label for showing the current value

        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            text: settings.jahrgang
        }


        Button{
            text: "Ändere deinen Jahrgang"
            elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: jahrgangChooser.show()
        }
        Label{
                anchors.horizontalCenter: parent.horizontalCenter
                text: settings.klasse

        }
        Button{
            id: klassenBtn
            text: "Ändere deine Klasse"
            elevation: 1
            enabled: !settings.hideKlasse
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: klassenChooser.show()
        }

/*
        Label{
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Units.dp(20)
            visible: !settings.hideKlasse
            text: "Dein Klassenbuchstabe:"
        }

        QuickControls.ComboBox {
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
        }*/
    }
    onKlasseChanged: {
        if(klasse !== "Alle" && klasse !== undefined && jahrgang < 11){
            settingStorage.letter = "/" + klasse
        }else{
            settingStorage.letter = ""
        }
    }

    onJahrgangChanged: {
        if(jahrgang !== "Alle" && jahrgang !== undefined){
            settingStorage.klasse = "/" + jahrgang
        }else{
            settingStorage = ""
        }
        if(jahrgang > 10){
            settingStorage.letter = ""
            settings.klasse = ""
            settings.hideKlasse = true
        }else{
            settings.hideKlasse = false
        }
    }


    Component.onCompleted: {
        // TODO Get the values back to the lsts
        jahrgang = settingStorage.klasse.split("/")[1]
        klasse = settingStorage.letter.split("/")[1]

        /*
        var lIndex = letterSelector.find(settingStorage.letter.split("/")[1])
        letterSelector.currentIndex = lIndex
        var kIndex = klassenSelector.find(settingStorage.klasse.split("/")[1])
        klassenSelector.currentIndex = kIndex
        */
    }
}
