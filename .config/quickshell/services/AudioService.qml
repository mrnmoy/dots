pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property list<PwNode> applications: Pipewire.nodes.values.filter(node => node.isStream === true)

    PwObjectTracker {
        objects: [root.sink, root.source, ...root.applications]
    }
}
