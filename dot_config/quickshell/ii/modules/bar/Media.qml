import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs
import qs.modules.common.functions

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland

Item {
    id: root
    property real iconSize: Appearance.sizes.icon
    property real textSize: Appearance.font.pixelSize.normal

    property string iconColor: ColorPalette.c1
    property string textColor: ColorPalette.c1

    property bool borderless: Config.options.bar.borderless
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    // readonly property string cleanedTitle: StringUtils.cleanMusicTitle(activePlayer?.trackTitle) || Translation.tr("No media")
    readonly property string cleanedTitle: StringUtils.cleanMusicTitle(activePlayer?.trackTitle)
    readonly property real barSpacing: Appearance.barSpacing

    readonly property real volume: Audio.sink.audio.volume

    Layout.fillHeight: true
    implicitWidth: rowLayout.implicitWidth

    Timer {
        running: activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: Config.options.resources.updateInterval
        repeat: true
        onTriggered: activePlayer.positionChanged()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton | Qt.RightButton | Qt.LeftButton
        onPressed: event => {
            if (event.button === Qt.MiddleButton) {
                activePlayer.togglePlaying();
            } else if (event.button === Qt.BackButton) {
                activePlayer.previous();
            } else if (event.button === Qt.ForwardButton || event.button === Qt.RightButton) {
                activePlayer.next();
            } else if (event.button === Qt.LeftButton) {
                GlobalStates.mediaControlsOpen = !GlobalStates.mediaControlsOpen;
            }
        }
    }

    RowLayout { // Real content
        id: rowLayout

        spacing: root.barSpacing
        height: root.height

        // ClippedFilledCircularProgress {
        //     id: mediaCircProg
        //     Layout.alignment: Qt.AlignVCenter
        //     lineWidth: Appearance.rounding.unsharpen
        //     value: activePlayer?.position / activePlayer?.length
        //     implicitSize: 20
        //     colPrimary: Appearance.colors.colOnSecondaryContainer
        //     enableAnimation: false
        //
        //     Item {
        //         anchors.centerIn: parent
        //         width: mediaCircProg.implicitSize
        //         height: mediaCircProg.implicitSize
        //
        //         MaterialSymbol {
        //             anchors.centerIn: parent
        //             fill: 1
        //             text: activePlayer?.isPlaying ? "pause" : "music_note"
        //             iconSize: Appearance.font.pixelSize.normal
        //             color: Appearance.m3colors.m3onSecondaryContainer
        //         }
        //     }
        // }

        MaterialSymbol {
            fill: 1
            Layout.alignment: Qt.AlignVCenter
            text: root.activePlayer?.isPlaying ? "pause" : "volume_up"
            iconSize: root.iconSize
            color: root.iconColor
        }

        StyledText {
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight // Truncates the text on the right
            text: `${root.cleanedTitle}${root.activePlayer?.trackArtist ? ' • ' + root.activePlayer.trackArtist : '%1%'.arg(Math.floor(root.volume * 100))}`
            color: root.textColor

            font: Appearance.fonts.bar

            // font {
            //     letterSpacing: .5
            //     pixelSize: root.textSize
            //     weight: Font.Bold
            // }
        }
    }
}
