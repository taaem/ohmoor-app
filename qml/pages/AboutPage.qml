import QtQuick 2.3
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1

Page {
    id: placeHolder
    title: "Über"
    Column{
        anchors.top: parent.bottom
        anchors.topMargin: Units.dp(20)
        anchors.left: parent.left
        anchors.leftMargin: Units.dp(10)
        anchors.fill: parent
        spacing: Units.dp(5)
        Label{
            font.pixelSize: Units.dp(20)
            font.underline: true
            text: "Über die Vertretungsplan App"
        }
        Label{
            font.pixelSize: Units.dp(15)
            text: "Entwickelt von Tim Klocke"
        }
        Label{
            font.pixelSize: Units.dp(15)
            text: "Sorce Code auf <a href='https://gitlab.com/taaem/vertretungsplan-client-qt5'>GitLab</a>"
            onLinkActivated: Qt.openUrlExternally(link)
        }
        Label{
            font.pixelSize: Units.dp(15)
            text: "Unter der BSD 2-Clause Lizenz"
            onLinkActivated: Qt.openUrlExternally(link)
        }

    }
}
