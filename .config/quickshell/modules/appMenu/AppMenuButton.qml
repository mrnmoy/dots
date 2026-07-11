import QtQuick
import QtQuick.Layouts
import "../../components"

BarButton {
    id: root

    active: appMenuPopup.visible
    onClicked: appMenuPopup.visible = !appMenuPopup.visible

    contentItem: Text {
        text: "AppMenuBtn"
        color: "#ffffff"
    }

    AppMenuPopup {
        id: appMenuPopup
        visible: true
    }
}
