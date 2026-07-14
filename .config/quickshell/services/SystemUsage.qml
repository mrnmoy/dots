pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool active: true

    property real cpuUsage: 0
    property real memUsage: memTotal > 0 ? memUsed / memTotal : 0
    property real diskUsage: diskTotal > 0 ? diskUsed / diskTotal : 0
    property real cpuTemp: 0

    property real memUsed: 0
    property real memTotal: 0
    property real diskUsed: 0
    property real diskTotal: 0

    property bool hasGpu: false
    property real gpuTemp: 0
    property real gpuMemUsed: 0
    property real gpuMemTotal: 0
    property real gpuUsage: 0
    property real gpuMemUsage: 0

    Process {
        id: cpuProcess
        running: false
        command: ["/bin/sh", "-c", "cat /proc/stat | grep '^cpu '"]

        stdout: SplitParser {
            onRead: data => {
                console.log("cpuProcess ", data);
            }
        }
    }

    Process {
        id: memProcess
        running: false
        command: ["/bin/sh", "-c", "free -b | grep Mem"]

        stdout: SplitParser {
            onRead: data => {
                console.log("memProcess ", data);
            }
        }
    }

    Process {
        id: diskProcess
        running: false
        command: ["/bin/sh", "-c", "df -B1 / | tail -1"]

        stdout: SplitParser {
            onRead: data => {
                console.log("memProcess ", data);
                const parts = data.trim().split(/\s+/);
                if (parts.length >= 3) {
                    root.diskTotal = parseInt(parts[1]);
                    root.diskUsed = parseInt(parts[2]);
                }
            // console.log("disk total" + root.diskTotal, "disk used" + root.diskUsed, "disk usage" + root.diskUsage);
            }
        }
    }

    Process {
        id: detectGpuProcess
        running: false
        command: ["/bin/sh", "-c", "if command -v nvidia-smi >/dev/null 2>&1; then echo 'nvidia'; elif command -v radeontop >/dev/null 2>&1; then echo 'amd'; elif
[ -d /sys/class/drm/card0/device/drm/card0 ]; then echo 'intel'; else echo 'none'; fi"]

        stdout: SplitParser {
            onRead: data => {
                console.log("detectGpuProcess ", data);
            }
        }
    }

    Process {
        id: netProcess
        running: false
        command: ["/bin/sh", "-c", "cat /proc/net/dev | tail -n +3 | awk '{rx+=$2; tx+=$10} END {print rx\" \"tx}'"]

        stdout: SplitParser {
            onRead: data => {
                console.log("netProcess ", data);
            }
        }
    }

    Timer {
        id: updateTimer
        interval: 1000
        repeat: true
        running: root.active
        triggeredOnStart: true

        onTriggered: {
            cpuProcess.running = true;
            memProcess.running = true;
            diskProcess.running = true;
            netProcess.running = true;
        }
    }

    Component.onCompleted: {
        detectGpuProcess.running = true;
    }
}
