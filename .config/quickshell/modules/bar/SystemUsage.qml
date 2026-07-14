import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

// import "../../components"

RowLayout {
    CircularProgressBar {
        size: 28
        lineWidth: 3
        icon: ""
        value: SystemUsage.cpuUsage
    }
    CircularProgressBar {
        size: 28
        lineWidth: 3
        icon: ""
        value: SystemUsage.memUsage
    }
    CircularProgressBar {
        size: 28
        lineWidth: 3
        icon: ""
        value: SystemUsage.diskUsage
    }
    CircularProgressBar {
        size: 28
        lineWidth: 3
        icon: ""
        value: SystemUsage.cpuTemp
    }
}
