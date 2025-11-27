import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import qs.modules.bar.weather

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Hyprland

Item {
    id: root

    property string barColor: Config.options.bar.showBackground ? ColorPalette.bg : "transparent"
    property string barBorderColor: ColorPalette.c8

    property string iconColor: ColorPalette.fg
    property string iconColor2: ColorPalette.bg
    property string iconColor3: ColorPalette.c8

    // padding from screen edges
    property real edgePadding: 4.0

    // spacing between elements
    property real itemSpacing: 8.0

    property real iconSize: Appearance.font.pixelSize.larger

    property var screen: root.QsWindow.window?.screen
    property var brightnessMonitor: Brightness.getMonitorForScreen(screen)
    property real useShortenedForm: (Appearance.sizes.barHellaShortenScreenWidthThreshold >= screen?.width) ? 2 : (Appearance.sizes.barShortenScreenWidthThreshold >= screen?.width) ? 1 : 0
    readonly property int centerSideModuleWidth: (useShortenedForm == 2) ? Appearance.sizes.barCenterSideModuleWidthHellaShortened : (useShortenedForm == 1) ? Appearance.sizes.barCenterSideModuleWidthShortened : Appearance.sizes.barCenterSideModuleWidth

    component VerticalBarSeparator: Rectangle {
        Layout.topMargin: Appearance.sizes.baseBarHeight / 3
        Layout.bottomMargin: Appearance.sizes.baseBarHeight / 3
        Layout.fillHeight: true
        implicitWidth: 1
        color: Appearance.colors.colOutlineVariant
    }

    // Background shadow
    Loader {
        active: Config.options.bar.showBackground && Config.options.bar.cornerStyle === 1
        anchors.fill: barBackground
        sourceComponent: StyledRectangularShadow {
            anchors.fill: undefined // The loader's anchors act on this, and this should not have any anchor
            target: barBackground
        }
    }

    // Background
    Rectangle {
        id: barBackground
        anchors {
            fill: parent
            margins: Config.options.bar.cornerStyle === 1 ? (Appearance.sizes.hyprlandGapsOut) : 0 // idk why but +1 is needed
        }
        color: root.barColor
        radius: Config.options.bar.cornerStyle === 1 ? Appearance.rounding.windowRounding : 0
        border.width: Config.options.bar.cornerStyle === 1 ? 1 : 0
        border.color: root.barBorderColor
    }

    FocusedScrollMouseArea { // Left side | scroll to change brightness
        id: barLeftSideMouseArea

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: middleSection.left
        }
        implicitWidth: leftSectionRowLayout.implicitWidth
        implicitHeight: Appearance.sizes.baseBarHeight

        onScrollDown: root.brightnessMonitor.setBrightness(root.brightnessMonitor.brightness - 0.05)
        onScrollUp: root.brightnessMonitor.setBrightness(root.brightnessMonitor.brightness + 0.05)
        onMovedAway: GlobalStates.osdBrightnessOpen = false
        onPressed: event => {
            if (event.button === Qt.LeftButton)
                GlobalStates.sidebarLeftOpen = !GlobalStates.sidebarLeftOpen;
        }

        // brightness scroll indicator on mouse hover
        ScrollHint {
            reveal: barLeftSideMouseArea.hovered
            icon: "light_mode"
            tooltipText: Translation.tr("Scroll to change brightness")
            side: "left"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        RowLayout {
            id: leftSectionRowLayout
            anchors.fill: parent
            // spacing: root.itemSpacing
            spacing: 0

            Item {
                // left spacer
                Layout.preferredWidth: root.edgePadding
            }

            // left button (ai) module
            LeftSidebarButton {
                // Left sidebar button
                Layout.alignment: Qt.AlignLeft
                Layout.preferredWidth: iconSize
                Layout.rightMargin: -8
                iconColor: root.iconColor3
                colBackground: barLeftSideMouseArea.hovered ? Appearance.colors.colLayer1Hover : ColorUtils.transparentize(Appearance.colors.colLayer1Hover, 1)
            }

            // active window module
            // ActiveWindow {
            //     visible: root.useShortenedForm === 0
            //     Layout.rightMargin: Appearance.rounding.screenRounding
            //     Layout.fillWidth: true
            //     Layout.fillHeight: true
            // }

            Workspaces {
                id: workspacesWidget
                Layout.alignment: Qt.AlignLeft
                Layout.fillHeight: true
                MouseArea {
                    // Right-click to toggle overview
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton

                    onPressed: event => {
                        if (event.button === Qt.RightButton) {
                            GlobalStates.overviewOpen = !GlobalStates.overviewOpen;
                        }
                    }
                }
            }
        }
    }

    RowLayout { // Middle section
        id: middleSection

        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: root.horizontalCenter
        }
        spacing: root.itemSpacing
        width: middleCenterGroup.implicitWidth

        VerticalBarSeparator {
            visible: Config.options?.bar.borderless
        }

        BarGroup {
            id: middleCenterGroup
            // padding: workspacesWidget.widgetPadding
            ClockWidget {
                // Layout.rightMargin: 40
                showDate: (Config.options.bar.verbose && root.useShortenedForm < 2)
            }
        }

        VerticalBarSeparator {
            visible: Config.options?.bar.borderless
        }
    }

    RowLayout {
        id: rightSectionRowLayout
        spacing: root.itemSpacing

        readonly property int iconSize: Appearance.font.pixelSize.larger + 4

        anchors {
            top: root.top
            bottom: root.bottom
            left: middleSection.right
            right: root.right
        }

        // DebugRect {}
        Item {
            Layout.fillWidth: true
        }

        UtilButtons {
            visible: (Config.options.bar.verbose && root.useShortenedForm === 0)
            Layout.alignment: Qt.AlignRight
        }

        SysTray {
            visible: root.useShortenedForm === 0 && hasItems
            invertSide: Config?.options.bar.bottom
            menuOffset: Qt.point(parent.x + x, parent.y + y + height)
        }

        // Weather
        Loader {
            Layout.leftMargin: 4
            visible: active
            active: Config.options.bar.weather.enable
            sourceComponent: BarGroup {
                WeatherBar {}
            }
        }

        TemperatureModule {}

        Media {
            // currently playing media
            visible: root.useShortenedForm < 2
        }

        Revealer {
            // audio muted icon
            reveal: Audio.sink?.audio?.muted ?? false
            Behavior on Layout.rightMargin {
                animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
            }
            MaterialSymbol {
                text: "volume_off"
                iconSize: root.iconSize
                // color: rightSidebarButton.colText
            }
        }

        Revealer {
            // mic muted icon
            reveal: Audio.source?.audio?.muted ?? false
            Behavior on Layout.rightMargin {
                animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
            }
            MaterialSymbol {
                text: "mic_off"
                iconSize: root.iconSize
                // color: rightSidebarButton.colText
            }
        }

        Loader {
            active: HyprlandXkb.layoutCodes.length > 1
            visible: active
            Layout.rightMargin: indicatorsRowLayout.realSpacing
            sourceComponent: StyledText {
                text: HyprlandXkb.currentLayoutCode
                font.pixelSize: Appearance.font.pixelSize.small
                color: rightSidebarButton.colText
                animateChange: true
            }
        }

        NetworkModule {}

        BluetoothModule {}

        BatteryModule {}

        MaterialSymbol {
            text: "menu"
            iconSize: Appearance.font.pixelSize.larger
            color: root.iconColor3
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.preferredWidth: iconSize
            Layout.fillHeight: true

            FocusedScrollMouseArea { // Right side | scroll to change volume
                id: barRightSideMouseArea
                anchors.fill: parent

                onScrollDown: {
                    const currentVolume = Audio.value;
                    const step = currentVolume < 0.1 ? 0.01 : 0.02 || 0.2;
                    Audio.sink.audio.volume -= step;
                }
                onScrollUp: {
                    const currentVolume = Audio.value;
                    const step = currentVolume < 0.1 ? 0.01 : 0.02 || 0.2;
                    Audio.sink.audio.volume = Math.min(1, Audio.sink.audio.volume + step);
                }
                onMovedAway: GlobalStates.osdVolumeOpen = false
                onPressed: event => {
                    if (event.button === Qt.LeftButton) {
                        GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
                    }
                }

                // Visual content
                ScrollHint {
                    anchors.centerIn: parent
                    anchors.right: parent.right
                    reveal: barRightSideMouseArea.hovered
                    icon: "volume_up"
                    tooltipText: Translation.tr("Scroll to change volume")
                    side: "right"
                }
            }
        }

        Item {
            // right spacer
            Layout.preferredWidth: root.edgePadding
        }
    }
}
