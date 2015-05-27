import QtQuick 2.3
import Material 0.1
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import com.taaem.vertretungsplan 1.0
import QtQuick.Layouts 1.1

Page {
    property bool loading
    property bool verifiedFailed
    id: page
    title: "Pläne"
    actions: [
        Action {
            iconName: "navigation/refresh"
            name: "Refresh"
            enabled: true
            onTriggered: {
                if(settingStorage.verified == true){
                    reloadDates()
                }
            }
        }
    ]
    Dialog {
        id: settings
        title: page.verifiedFailed == false ? "Login" : "Try Again"
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            TextField{
                id: usernameInput
                placeholderText: "Username"
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhEmailCharactersOnly
                //anchors.horizontalCenter:parent.horizontalCenter
            }
            TextField{
                id: passwordInput
                placeholderText: "Passwort"
                //anchors.horizontalCenter:parent.horizontalCenter
                echoMode: TextInput.Password
            }
        }
        onAccepted: {
            plan.verifyUser(usernameInput.text, passwordInput.text)
        }
    }

    ProgressCircle{
        id: mainCircle
        anchors.centerIn: parent
        color: Theme.accentColor
        visible: loading ? true : false
    }
    ListView{
        anchors.fill: parent
        id: mainList
        clip: true
        model: ListModel{}
        spacing: 10
        delegate: ListItem.Standard{
            text: date
            onClicked: {
                pageStack.push(Qt.resolvedUrl("Plan.qml"), {dateHref: href})
            }
        }
    }
    Vertretungsplan{
        id: plan
        onDatesReceived: {
            mainList.model.append(date)
            page.loading = false
        }
        onLoadingDates:{
            page.loading = true
        }
        onUserIsVerified:{
            getAllDates()
            settingStorage.verified = true
        }

        onVerifiedFailed:{
            page.verifiedFailed = true
            settings.show()
        }
    }
    function reloadDates(){
        mainList.model.clear()
        plan.getAllDates()
    }

    Component.onCompleted: (settingStorage.verified == true) ? reloadDates() : settings.show()
}
