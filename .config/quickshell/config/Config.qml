pragma Singleton

import QtQuick
import Quickshell
import "../services"

Singleton {
    id: root

    readonly property var launcher: ({
            favourites: ["Alacritty", "Zen Browser", "thunar",]
        })

    readonly property var onScreenNotification: ({
            maxLength: 3,
            timeout: 5000
        })

    readonly property var appearence: ({
            theme: "auto" | "light" | "dark",
            // accentColor: "#E3701B",
            accentColor: "red",
            colors: WallpaperService.colors,
            animationDuration: 250,
            timeout: 0
        })
    onAppearenceChanged: console.log("appearence changed", appearence.colors.primary)

    readonly property var media: ({
            lyricsEnabled: true,
            blacklist: ["Mozilla zen"]
        })
}
