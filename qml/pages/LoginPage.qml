import QtQuick 2.3
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import com.taaem.vertretungsplan 1.0
import QtQuick.Layouts 1.1

Page {
    id: login
    property bool verifiedFailed
    title: !verifiedFailed ? "Login" : "Try Again"
    Column {
        anchors.top: parent.bottom
        anchors.topMargin: Units.dp(20)
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Units.dp(20)
        TextField{
            anchors.horizontalCenter: parent.horizontalCenter
            id: usernameInput
            placeholderText: "Username"
            inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhEmailCharactersOnly
            font.pixelSize: Units.dp(20)
            //anchors.horizontalCenter:parent.horizontalCenter
        }
        TextField{
            anchors.horizontalCenter: parent.horizontalCenter
            id: passwordInput
            placeholderText: "Passwort"
            font.pixelSize: Units.dp(20)
            //anchors.horizontalCenter:parent.horizontalCenter
            echoMode: TextInput.Password
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            backgroundColor: theme.accentColor
            text: "Login"
            onClicked:{
                plan.verifyUser(usernameInput.text, passwordInput.text)
            }
        }
    }
    Vertretungsplan{
        id: plan
        onUserIsVerified:{
            settingStorage.verified = true
            pageStack.push({item: Qt.resolvedUrl("Ubersicht.qml"), replace: true})
        }
        onVerifiedFailed:{
            settings.verifiedFailed = true
        }
    }


}
