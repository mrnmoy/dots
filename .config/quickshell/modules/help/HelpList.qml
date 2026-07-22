import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config"
import "../../controls"
import "../../services"

ListView {
    id: list
    model: apps
    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true

    readonly property list<DesktopEntry> apps: DesktopEntries.applications.values ?? []

    delegate: Rectangle {
        id: card

        required property DesktopEntry modelData
        required property int index

        width: list.width
        height: 60
        radius: 20
        color: list.currentIndex === index ? "#0fffffff" : "transparent"

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                Layout.fillHeight: true
                implicitWidth: height
                Layout.margins: 8

                Image {
                    id: appIcon
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    property int sourceIndex: 0
                    property var iconSources: [`/usr/share/pixmaps/${card.modelData.icon}`, `/usr/share/icons/hicolor/scalable/apps/${card.modelData.icon}.svg`, `/usr/share/icons/hicolor/32x32/apps/${card.modelData.icon}`]

                    source: iconSources[sourceIndex]
                    asynchronous: true
                    onStatusChanged: {
                        if (status === Image.Error) {
                            if (sourceIndex < iconSources.length - 1)
                                sourceIndex = sourceIndex + 1;
                            else
                                visible = false;
                        }
                    }
                }

                Rectangle {
                    radius: 20
                    color: "#0fffffff"
                    anchors.fill: parent
                    visible: !appIcon.visible

                    Text {
                        anchors.centerIn: parent
                        text: card.modelData.name.slice(0, 1).toUpperCase()
                        font.family: "Inter"
                        font.pixelSize: 20
                        font.weight: Font.DemiBold
                        color: "#ffffff"
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                    Layout.fillWidth: true
                    text: card.modelData.name ?? "Unknown"
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    color: "#ffffff"
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    text: card.modelData.comment || card.modelData.genericName || card.modelData.execString || "Launch"
                    font.family: "Inter"
                    font.pixelSize: 12
                    color: "#ffffff"
                    elide: Text.ElideRight
                }
            }
        }

        TapHandler {
            cursorShape: Qt.PointingHandCursor
            onTapped: {
                root.launch();
            }
        }
        //                 MouseArea {
        //                     anchors.fill: parent
        //                     hoverEnabled: true
        //                     cursorShape: Qt.PointingHandCursor
        //                     onEntered: root.selectedIndex = card.index
        //                     onClicked: {
        //                         card.modelData.execute();
        //                         root.close();
        //                     }
        //                 }
    }
}
