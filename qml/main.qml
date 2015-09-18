import QtQuick 2.4
import Material 0.1
import "pages"
import Qt.labs.settings 1.0
import com.taaem.vertretungsplan 1.0

ApplicationWindow {
    title: "Vertretungsplan"
    id: appWindow
    width: 640
    height: 480
    visible: true
    property string version: "v0.7.2"

    theme {
            primaryColor: Palette.colors["red"]["500"]
            primaryDarkColor: Palette.colors["red"]["700"]
            accentColor: Palette.colors["blue"]["500"]
            tabHighlightColor: "white"
        }
    Settings {
        id: settingStorage
        property string klasse: ""
        property string letter: ""
        property bool verified: false
    }
    initialPage: (settingStorage.verified)? Qt.resolvedUrl("pages/Ubersicht.qml") : Qt.resolvedUrl("pages/LoginPage.qml")
}
