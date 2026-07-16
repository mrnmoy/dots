pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int sinkVolume: 50
    property bool sinkMuted: false

    property int sourceVolume: 0
    property bool sourceMuted: false

    function setSinkVolume(value: int): void { // Volume in percent
        setSinkVolProc.volume = value;
        setSinkVolProc.running = true;
    }
    function setSourceVolume(value: int): void { // Volume in percent
        setSourceVolProc.volume = value;
        setSourceVolProc.running = true;
    }

    // Timer {
    //     running: true
    //     repeat: true
    //     interval: 1000
    //     onTriggered: {
    //         if (!getSinkProc.running)
    //             getSinkProc.running = true;
    //         if (!getSourceProc.running)
    //             getSourceProc.running = true;
    //     }
    // }

    Process {
        id: getSinkProc
        command: ["/bin/sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
        stdout: StdioCollector {
            onStreamFinished: {
                const s = text.trim();
                const v = parseFloat(s.match(/Volume:\s*([0-9.]+)/)[1]) * 100;
                root.sinkVolume = v;
                root.sinkMuted = /\[MUTED\]/.test(s);
            }
        }
    }

    Process {
        id: getSourceProc
        command: ["/bin/sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SOURCE@"]
        stdout: StdioCollector {
            onStreamFinished: {
                const s = text.trim();
                const v = parseFloat(s.match(/Volume:\s*([0-9.]+)/)[1]) * 100;
                root.sourceVolume = v;
                root.sourceMuted = /\[MUTED\]/.test(s);
            }
        }
    }

    Process {
        id: setSinkVolProc
        property int volume: 0
        command: ["/bin/sh", "-c", `wpctl set-volume @DEFAULT_AUDIO_SINK@ ${volume}%`]
    }
    Process {
        id: setSourceVolProc
        property int volume: 0
        command: ["/bin/sh", "-c", `wpctl set-volume @DEFAULT_AUDIO_SOURCE@ ${volume}%`]
    }

    Component.onCompleted: {
        getSinkProc.running = true;
        getSourceProc.running = true;
    }
}
