import QtQuick
import QtQuick.Layouts
import qs
import qs.modules.common
import qs.modules.common.widgets
import qs.services

RippleButton {
    // CustomIcon {
    //     id: distroIcon
    //     anchors.centerIn: parent
    //     width: root.iconSize
    //     height: root.iconSize
    //     source: Config.options.bar.topLeftIcon == 'distro' ? SystemInfo.distroIcon : `${Config.options.bar.topLeftIcon}-symbolic`
    //     colorize: true
    //     color: root.iconColor
    //     Rectangle {
    //         opacity: root.showPing ? 1 : 0
    //         visible: opacity > 0
    //         implicitWidth: 8
    //         implicitHeight: 8
    //         radius: Appearance.rounding.full
    //         color: Appearance.colors.colTertiary
    //         anchors {
    //             bottom: parent.bottom
    //             right: parent.right
    //             bottomMargin: -2
    //             rightMargin: -2
    //         }
    //         Behavior on opacity {
    //             animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    //         }
    //     }
    // }

    id: root

    // property color iconColor: Appearance.colors.colOnLayer0
    property color iconColor: "white"
    property real iconSize: 20
    property bool showPing: false
    property real buttonPadding: 0

    // implicitWidth: distroIcon.width + buttonPadding * 2
    // implicitHeight: distroIcon.height + buttonPadding * 2

    buttonRadius: Appearance.rounding.full
    colBackgroundHover: Appearance.colors.colLayer1Hover
    colRipple: Appearance.colors.colLayer1Active
    colBackgroundToggled: Appearance.colors.colSecondaryContainer
    colBackgroundToggledHover: Appearance.colors.colSecondaryContainerHover
    colRippleToggled: Appearance.colors.colSecondaryContainerActive
    toggled: GlobalStates.sidebarLeftOpen
    onPressed: {
        GlobalStates.sidebarLeftOpen = !GlobalStates.sidebarLeftOpen;
    }

    Connections {
        function onResponseFinished() {
            if (GlobalStates.sidebarLeftOpen)
                return;

            root.showPing = true;
        }

        target: Ai
    }

    Connections {
        function onResponseFinished() {
            if (GlobalStates.sidebarLeftOpen)
                return;

            root.showPing = true;
        }

        target: Booru
    }

    Connections {
        function onSidebarLeftOpenChanged() {
            root.showPing = false;
        }

        target: GlobalStates
    }

    MaterialSymbol {
        text: "adjust"
        fill: 0
        anchors.fill: parent
        iconSize: root.iconSize
        color: root.iconColor
    }
}
