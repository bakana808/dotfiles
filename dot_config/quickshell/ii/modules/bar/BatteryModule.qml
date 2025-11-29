import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.modules.common
import qs.modules.common.widgets
import qs.services

MouseArea {
    id: root

    readonly property real useShortenedForm: (Appearance.sizes.barHellaShortenScreenWidthThreshold >= screen?.width) ? 2 : (Appearance.sizes.barShortenScreenWidthThreshold >= screen?.width) ? 1 : 0

    // if true, animate the battery icon when charging
    readonly property bool animatedCharging: true

    readonly property var chargeState: Battery.chargeState
    readonly property bool isCharging: Battery.isCharging
    readonly property bool isPluggedIn: Battery.isPluggedIn
    readonly property real percentage: Battery.percentage
    readonly property bool isLow: percentage <= Config.options.battery.low / 100

    property color iconColor: ColorPalette.c2
    property color bgColor: ColorPalette.bg

    property bool borderless: Config.options.bar.borderless
    property int iconSize: 20
    readonly property int textSize: Appearance.font.pixelSize.normal
    readonly property real barSpacing: Appearance.barSpacing

    visible: (root.useShortenedForm < 2 && UPower.displayDevice.isLaptopBattery)
    hoverEnabled: true

    Layout.fillHeight: true

    height: layout.implicitHeight
    width: layout.implicitWidth

    Timer {
        id: chargeIconTimer
        property int frame: 0
        interval: 500
        running: root.animatedCharging && root.chargeState == UPowerDeviceState.Charging
        repeat: true
        onTriggered: frame = (frame + 1) % 8
        property string icon: {
            switch (frame) {
            case 7:
                return "battery_full";
            default:
                return "battery_%1_bar".arg(frame);
            }
        }
    }

    RowLayout {
        id: layout

        spacing: root.barSpacing - 2
        height: root.height

        MaterialSymbol {
            id: batteryIcon

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: -6

            iconSize: root.iconSize
            color: root.iconColor

            text: {
                switch (root.chargeState) {
                case UPowerDeviceState.Unknown:
                    return "battery_unknown";
                case UPowerDeviceState.Empty:
                    return "battery_0_bar";
                case UPowerDeviceState.FullyCharged:
                case UPowerDeviceState.PendingCharge:
                    return "battery_full";
                case UPowerDeviceState.Charging:
                    if (root.animatedCharging)
                        return chargeIconTimer.icon;
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

            Revealer {
                id: chargeIcon
                reveal: root.isPluggedIn

                anchors.bottom: batteryIcon.bottom
                anchors.right: batteryIcon.right
                anchors.bottomMargin: 5
                anchors.rightMargin: 1

                readonly property real size: root.iconSize - 10

                Rectangle {
                    width: parent.size
                    height: parent.size
                    color: root.bgColor
                    radius: parent.size

                    MaterialSymbol {
                        anchors.centerIn: parent
                        color: root.iconColor
                        text: "bolt"
                        iconSize: chargeIcon.size - 2
                    }
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
