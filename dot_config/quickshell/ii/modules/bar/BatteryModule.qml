import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    id: root

    readonly property real useShortenedForm: (Appearance.sizes.barHellaShortenScreenWidthThreshold >= screen?.width) ? 2 : (Appearance.sizes.barShortenScreenWidthThreshold >= screen?.width) ? 1 : 0

    readonly property var chargeState: Battery.chargeState
    readonly property bool isCharging: Battery.isCharging
    readonly property bool isPluggedIn: Battery.isPluggedIn
    readonly property real percentage: Battery.percentage
    readonly property bool isLow: percentage <= Config.options.battery.low / 100

    property color iconColor: ColorPalette.c2

    property bool borderless: Config.options.bar.borderless
    property int iconSize: 20
    readonly property int textSize: Appearance.font.pixelSize.normal
    readonly property real barSpacing: Appearance.barSpacing

    visible: (root.useShortenedForm < 2 && UPower.displayDevice.isLaptopBattery)
    hoverEnabled: true
    // implicitWidth: batteryProgress.implicitWidth
    Layout.fillHeight: true
    height: layout.implicitHeight
    width: layout.implicitWidth

    RowLayout {
        id: layout

        spacing: root.barSpacing - 2
        height: root.height

        Revealer {
            reveal: root.isPluggedIn
            Layout.leftMargin: -2

            MaterialSymbol {
                color: root.iconColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                fill: 1
                text: "bolt"
                iconSize: root.iconSize - 10
            }
        }

        MaterialSymbol {
            id: batteryIcon

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            iconSize: root.iconSize
            color: root.iconColor

            text: {
                switch (root.chargeState) {
                case UPowerDeviceState.FullyCharged:
                case UPowerDeviceState.PendingCharge:
                    return "battery_full";
                default:
                    if (root.percentage >= 0.95)
                        return "battery_full";

                    if (root.percentage >= 0.9)
                        return "battery_6_bar";

                    if (root.percentage >= 0.8)
                        return "battery_5_bar";

                    if (root.percentage >= 0.6)
                        return "battery_4_bar";

                    if (root.percentage >= 0.5)
                        return "battery_3_bar";

                    if (root.percentage >= 0.3)
                        return "battery_2_bar";

                    if (root.percentage >= 0.2)
                        return "battery_1_bar";

                    return "battery_alert";
                }
            }
        }

        StyledText {
            text: "%1%".arg(Math.floor(root.percentage * 100))
            verticalAlignment: Text.AlignVCenter
            color: root.iconColor

            font: Appearance.fonts.bar
        }
    }

    BatteryPopup {
        id: batteryPopup
        hoverTarget: root
    }
}
