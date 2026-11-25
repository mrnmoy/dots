import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../services"
import "../../config"

PanelWindow {
    id: root
    visible: ShellState.wallpaper

    property int selectedIndex: 0

    // anchors.top: true
    // anchors.right: true
    // anchors.bottom: true
    exclusionMode: ExclusionMode.Normal
    // exclusionMode: ExclusionMode.Ignore

    implicitWidth: Math.min(1280, screen.width - 40)
    implicitHeight: Math.min(720, screen.height - 40)
    color: "transparent"

    screen: Quickshell.screens[0]
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    FocusScope {
        id: panelContent
        anchors.fill: parent

        transformOrigin: Item.TopRight
        scale: visible ? 1.0 : 0.5
        opacity: visible ? 1.0 : 0.0
        focus: true

        Keys.onEscapePressed: ShellState.wallpaper = false
        // Keys.onUpPressed: if (root.selectedIndex > 2)
        //     root.selectedIndex = root.selectedIndex - 3
        // Keys.onDownPressed: if (root.selectedIndex < 4 - 3)
        //     root.selectedIndex = root.selectedIndex + 3
        // Keys.onLeftPressed: if (root.selectedIndex > 0)
        //     root.selectedIndex = root.selectedIndex - 1
        // Keys.onRightPressed: if (root.selectedIndex < 3)
        //     root.selectedIndex = root.selectedIndex + 1
        Keys.onReturnPressed: WallpaperService.setWallpaper(WallpaperService.wallpapers[root.selectedIndex])

        Keys.onUpPressed: if (root.selectedIndex > 2)
            root.selectedIndex = root.selectedIndex - 3
        Keys.onDownPressed: if (root.selectedIndex < WallpaperService.wallpapers.length - 3)
            root.selectedIndex = root.selectedIndex + 3
        Keys.onLeftPressed: if (root.selectedIndex > 0)
            root.selectedIndex = root.selectedIndex - 1
        Keys.onRightPressed: if (root.selectedIndex < WallpaperService.wallpapers.length)
            root.selectedIndex = root.selectedIndex + 1

        Rectangle {
            id: panel
            anchors.fill: parent
            // anchors.margins: 16
            radius: 20
            color: "#0fffffff"
            clip: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: "Wallpapers"
                        font.pixelSize: 32
                        font.bold: true
                        color: "white"
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    // ComboBox {
                    //     model: ["Desktop", "Documents", "Downloads"]
                    //     editable: true
                    // }
                    // Button {
                    //     text: "Folder: " + Config.wallpapersDir
                    //     onClicked: folderDialog.open()
                    // }

                    // FolderDialog {
                    //     id: folderDialog
                    //     // currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                    // }
                }

                ScrollView {
                    id: wallpaperList
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        visible: WallpaperService.loading
                        text: "Loading..."
                        color: "white"
                        anchors.centerIn: parent
                    }

                    // Loader {
                    //     id: wallpapersListLoader
                    //     active: !WallpaperService.loading

                    GridLayout {
                        columns: 3
                        rowSpacing: 20
                        columnSpacing: 20
                        uniformCellWidths: true
                        uniformCellHeights: true
                        anchors.fill: parent

                        Repeater {
                            model: WallpaperService.wallpapers

                            delegate: Item {
                                id: card
                                required property string modelData
                                // required property string model
                                required property int index
                                property bool vertical: image.sourceSize.width > image.sourceSize.height

                                implicitWidth: 400
                                // implicitHeight: vertical ? 400 : 225
                                implicitHeight: 225
                                scale: index === root.selectedIndex ? 1.05 : 1
                                // Layout.rowSpan: vertical ? 2 : 1
                                Layout.rowSpan: 1
                                Behavior on scale {
                                    NumberAnimation {
                                        duration: 180
                                    }
                                }
                                Image {
                                    id: image
                                    anchors.fill: parent
                                    source: modelData
                                    fillMode: Image.PreserveAspectCrop
                                    cache: false
                                }
                                TapHandler {
                                    onTapped: {
                                        WallpaperService.setWallpaper(modelData);
                                    }
                                }
                            }
                        }
                    }
                    // }
                }
            }

            // GridView {
            //     id: wallpaperList
            //     anchors.fill: parent
            //     // anchors.margins: 16
            //     anchors.topMargin: 16
            //     anchors.bottomMargin: 16
            //     anchors.leftMargin: 16
            //     anchors.rightMargin: 16
            //     // model: WallpaperService.wallpapers
            //     model: ListModel {
            //         ListElement {
            //             uri: "/home/mrinmoy/Documents/can-anyone-please-give-me-similar-wallpaper-for-laptop-and-v0-motbre9rx6ag1.webp"
            //         }
            //         ListElement {
            //             uri: "/home/mrinmoy/Documents/can-anyone-please-give-me-similar-wallpaper-for-laptop-and-v0-motbre9rx6ag1.webp"
            //         }
            //         ListElement {
            //             uri: "/home/mrinmoy/Documents/can-anyone-please-give-me-similar-wallpaper-for-laptop-and-v0-motbre9rx6ag1.webp"
            //         }
            //         ListElement {
            //             uri: "/home/mrinmoy/Documents/can-anyone-please-give-me-similar-wallpaper-for-laptop-and-v0-motbre9rx6ag1.webp"
            //         }
            //     }
            //     cellWidth: 416
            //     cellHeight: 234
            //
            //     // highlight: Rectangle {
            //     //     color: "#8fff0000"
            //     //     // border.width: 2
            //     //     // border.color: "#ff0000"
            //     //     // scale: 1.05
            //     // }
            //
            //     delegate: Item {
            //         width: wallpaperList.cellWidth - 16
            //         height: wallpaperList.cellHeight - 16
            //         // scale: index === wallpaperList.currentIndex ? 1.1 : 0
            //         Rectangle {
            //             anchors.fill: parent
            //             color: "#0fffffff"
            //         }
            //         // Image {
            //         //     anchors.fill: parent
            //         //     source: uri
            //         //     fillMode: Image.PreserveAspectCrop
            //         // }
            //     }
            // }
        }
    }
}
