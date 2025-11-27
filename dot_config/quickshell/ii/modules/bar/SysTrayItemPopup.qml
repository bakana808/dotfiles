import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.widgets

StyledPopup {
    id: root

    required property SystemTrayItem item
    readonly property string itemTitle: item.tooltipTitle || item.title || item.id
    readonly property string itemDesc: item.tooltipDescription
    readonly property real iconSize: 16
    readonly property color textColor: Appearance.colors.colOnSurfaceVariant
    readonly property font textFont: ({
        "family": Appearance.font.family.main,
        "pixelSize": Appearance.font.pixelSize.smaller
    })
    readonly property font headerFont: ({
        "family": Appearance.font.family.title,
        "pixelSize": Appearance.font.pixelSize.small,
        "weight": Font.Bold
    })

    ColumnLayout {
        id: columnLayout

        anchors.centerIn: parent
        spacing: 4

        // tray item title
        RowLayout {
            id: header

            spacing: 5
            Layout.fillWidth: true

            IconImage {
                source: root.item.icon
                implicitSize: root.iconSize
            }

            StyledText {
                text: root.itemTitle
                color: root.textColor
                font: root.headerFont
                horizontalAlignment: Text.AlignHCenter
            }

        }

        // tray item description
        RowLayout {
            spacing: 5
            Layout.fillWidth: true
            visible: root.itemDesc

            StyledText {
                text: root.itemDesc
                font: root.textFont
                color: root.textColor
            }

        }

    }

}
