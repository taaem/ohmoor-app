import QtQuick 2.3
import Material 0.1
import Material.ListItems 0.1 as ListItem
import com.taaem.vertretungsplan 1.0

Page {
    id: login
    property bool verifiedFailed
    property bool verifying
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
            Keys.onReturnPressed: passwordInput.forceActiveFocus()
        }
        TextField{
            anchors.horizontalCenter: parent.horizontalCenter
            id: passwordInput
            placeholderText: "Passwort"
            font.pixelSize: Units.dp(20)
            //anchors.horizontalCenter:parent.horizontalCenter
            echoMode: TextInput.Password
            Keys.onReturnPressed: {
                loginBtn.forceActiveFocus(); 
                login.iservLogin()
            }
        }
        Button{
            id: loginBtn
            anchors.horizontalCenter: parent.horizontalCenter
            backgroundColor: theme.accentColor
            text: "Login"
            onClicked:{
                login.iservLogin()
            }
        }
        ProgressCircle{
            id: progress
            visible: login.verifying
            anchors.horizontalCenter: parent.horizontalCenter
            color: theme.accentColor
        }
    }
    function iservLogin(){
        if(usernameInput.text !== "" && passwordInput.text !== ""){
            plan.verifyUser(usernameInput.text, passwordInput.text)
            login.verifying = true
        }else if(usernameInput.text == ""){
            usernameInput.hasError = true
        }else{
            passwordInput.hasError = true
        }
    }

    Component.onCompleted: usernameInput.forceActiveFocus()
    Vertretungsplan{
        id: plan
        onUserIsVerified:{
            settingStorage.verified = true
            pageStack.push({item: Qt.resolvedUrl("Ubersicht.qml"), replace: true})
            login.verifying = false
        }
        onVerifiedFailed:{
            login.verifying = false
            settings.verifiedFailed = true
        }
    }


}
