import QtQuick 2.3
import Material 0.1
import com.taaem.updater 1.0

Page {
    id: page
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

        Label{
            font.pixelSize:  Units.dp(15)
            text: "Version: " + appWindow.version
        }

        Button{
            text: "Nach Updates Suchen"
            backgroundColor: theme.accentColor
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: updater.getLatestVersionNumber()
        }
        Label{
            text: "Kein Update verfügbar"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: updater.noUpdate
        }

        Column{
            id: newRelCol
            width:parent.width / 1.2
            anchors.horizontalCenter: parent.horizontalCenter
            visible: updater.update

            Label{
                text: updater.versionNumber
            }
            Label{
                text: "<b>" + updater.versionText + "</b>"
                textFormat: Text.RichText

            }
            Label{
                text: updater.changelog
                width: parent.width
                wrapMode: Text.Wrap
            }

            Button{
                text: "Download"
                backgroundColor: theme.accentColor
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: Qt.openUrlExternally(updater.downloadUrl)
            }
        }

    }
    Updater{
        id: updater
        property string versionNumber
        property string changelog
        property string downloadUrl
        property string versionText
        property bool update
        property bool noUpdate

        onGotLatestVersionNumber: {
            if(allData[1] !== appWindow.version){
                versionNumber = allData[1]
                changelog = allData[3]
                downloadUrl = allData[0]
                versionText = allData[2]
                update = true
            }else{
                noUpdate = true
            }
        }
    }
}
