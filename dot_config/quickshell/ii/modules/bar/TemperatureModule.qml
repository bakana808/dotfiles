import qs.services
import qs.modules.common.widgets
import qs.modules.common

import QtQuick
import QtQuick.Layouts

MouseArea {
    id: root

    property real iconSize: Appearance.sizes.icon
    property string color: ColorPalette.c5

    implicitWidth: rowLayout.width
    implicitHeight: rowLayout.height

    hoverEnabled: true

    RowLayout {
        id: rowLayout
        spacing: 0

        MaterialSymbol {
            iconSize: root.iconSize
            color: root.color

            text: "device_thermostat"
        }
        StyledText {
            verticalAlignment: Text.AlignVCenter
            text: ResourceUsage.cpuTemp !== null ? `${ResourceUsage.cpuTemp}°C` : "N/A"
            font: Appearance.fonts.bar
            color: root.color
        }
    }
}
