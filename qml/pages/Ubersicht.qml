import QtQuick 2.3
import Material 0.1
import Material.ListItems 0.1 as ListItem
import com.taaem.vertretungsplan 1.0

Page {
    property bool loading
    property bool reload
    property bool noPlanAvailable
    id: page
    title: "Pläne"
    actionBar.maxActionCount: 2
    actions: [
        Action {
            iconName: "navigation/refresh"
            name: "Neu Laden"
            enabled: true
            onTriggered: {
                if(settingStorage.verified == true){
                    reload = true
                }
            }
        },
        Action {
            iconName: "action/settings"
            name: "Einstellungen"
            onTriggered: pageStack.push(Qt.resolvedUrl("Settings.qml"))
        },
        Action {
            iconName: "action/code"
            name: "Über"
            onTriggered: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
        }
    ]


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
        header: Label{
            id: headerLabel
            anchors.horizontalCenter: parent.horizontalCenter
            text: (page.noPlanAvailable) ? "Keine Vertretungspläne vorhanden!" : ""
            wrapMode: Text.Wrap
            font.pixelSize: Units.dp(15)
        }

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
        onNoPlansAvailable:{
            page.noPlanAvailable = true
            page.loading = false
        }

        onDatesReceived: {
            mainList.model.append(date)
            page.loading = false
        }
        onLoadingDates:{
            page.loading = true
        }
    }
     onReloadChanged:{
        if(reload === true){
            mainList.model.clear()
            plan.getAllDates()
            reload = false
        }
    }

    Component.onCompleted: {
        if(settingStorage.verified == true){
            reload = true
        }
    }
}
