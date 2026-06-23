import Quickshell
import QtQuick
import qs

Text {
    font: Config.options.fontNormal
    color: Config.options.fontColor
    text: Qt.formatDateTime(clock.date, "ddd, M/d • h:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
