import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.status

// qmllint disable uncreatable-type
PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    color: Config.options.bar.color
    implicitHeight: Config.options.bar.height

    RowLayout {
        id: leftSection
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: Config.options.bar.margin

        MaterialIcon {
            name: "token"
            fill: false
            color: Config.colors.c8
        }

        StatusWorkspaces {}
    }

    RowLayout {
        id: middleSection
        anchors.centerIn: parent

        StatusClock {}
    }

    RowLayout {
        id: rightSection
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: Config.options.bar.margin

        MaterialIcon {
            name: "menu"
            color: Config.colors.c8
        }
    }
}
