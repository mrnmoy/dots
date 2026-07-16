pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property real sinkVolume: sink.audio.volume
    readonly property bool sinkMuted: sink.audio.muted

    readonly property real sourceVolume: source.audio.volume
    readonly property bool sourceMuted: source.audio.muted

    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    // onSinkVolumeChanged: console.info("sink vol changed ", sinkVolume)
    // onSourceVolumeChanged: console.info("source vol changed ", sourceVolume)

    function setSinkVolume(value: real): void {
        sink.audio.volume = value;
    }
    function setSourceVolume(value: real): void {
        source.audio.volume = value;
    }
}
