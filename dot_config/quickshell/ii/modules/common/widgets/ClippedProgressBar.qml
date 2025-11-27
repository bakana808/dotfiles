import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

/**
 * A progress bar with both ends rounded and text acts as clipping like OneUI 7's battery indicator.
 */
ProgressBar {
    id: root

    property bool vertical: false
    property real valueBarWidth: 26
    property real valueBarHeight: 14
    // property color highlightColor: Appearance?.colors.colOnSecondaryContainer ?? "#685496"
    // property color trackColor: ColorUtils.transparentize(highlightColor, 0.5) ?? "#F1D3F9"
    property color highlightColor: Config.colors.colors.color1
    readonly property color normalColor: Config.colors.colors.color15
    readonly property color lowColor: Config.colors.colors.color1
    property color trackColor: Config.colors.colors.color7

    property alias radius: contentItem.radius
    property string text

    default property Item textMask: Item {
        width: root.valueBarWidth
        height: root.valueBarHeight
        StyledText {
            anchors.centerIn: parent
            font: root.font
            text: root.text
        }
    }

    text: Math.round(value * 100)

    font {
        pixelSize: Appearance.font.pixelSize.smaller
        weight: text.length > 2 ? Font.Medium : Font.DemiBold
    }

    background: Item {
        implicitHeight: valueBarHeight
        implicitWidth: valueBarWidth
    }

    contentItem: Rectangle {
        id: contentItem
        anchors.fill: parent
        radius: 4
        color: root.trackColor
        visible: false

        Rectangle {
            id: progressFill
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: undefined
            }
            width: parent.width * root.visualPosition
            height: parent.height

            states: State {
                name: "vertical"
                when: root.vertical
                AnchorChanges {
                    target: progressFill
                    anchors {
                        top: undefined
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }
                }
                PropertyChanges {
                    target: progressFill
                    width: parent.width
                    height: parent.height * root.visualPosition
                }
            }

            // radius: Appearance.rounding.unsharpen
            color: root.highlightColor
        }
    }

    OpacityMask {
        id: roundingMask
        visible: false
        anchors.fill: parent
        source: contentItem
        maskSource: Rectangle {
            width: contentItem.width
            height: contentItem.height
            radius: contentItem.radius
        }
    }

    OpacityMask {
        anchors.fill: parent
        source: roundingMask
        invert: true
        maskSource: root.textMask
    }
}
