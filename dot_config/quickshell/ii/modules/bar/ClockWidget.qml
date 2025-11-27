import QtQuick
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    // implicitHeight: Appearance.sizes.barHeight
    // implicitWidth: rowLayout.implicitWidth
    // implicitWidth: dateTimeText.width
    // width: 40

    id: root

    property bool borderless: Config.options.bar.borderless
    property bool showDate: Config.options.bar.verbose

    hoverEnabled: true
    width: dateTimeText.width

    StyledText {
        id: dateTimeText

        height: root.height
        visible: root.showDate
        horizontalAlignment: Text.AlignLeft
        color: Appearance.colors.colOnLayer1
        text: `${DateTime.date} • ${DateTime.time}`

        font: Appearance.fonts.bar
    }

    ClockWidgetTooltip {
        hoverTarget: root
    }
}
