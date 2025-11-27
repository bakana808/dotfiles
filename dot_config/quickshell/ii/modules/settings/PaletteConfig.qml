import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "format_paint"
        title: Translation.tr("Colors")
        Layout.fillWidth: true

        ColumnLayout {
            Item {
                implicitWidth: 340
                implicitHeight: 200

                StyledImage {
                    id: wallpaperPreview
                    anchors.fill: parent
                    sourceSize.width: parent.implicitWidth
                    sourceSize.height: parent.implicitHeight
                    fillMode: Image.PreserveAspectCrop
                    source: Config.options.background.wallpaperPath
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: 360
                            height: 200
                            radius: Appearance.rounding.normal
                        }
                    }
                }
            }

            RippleButtonWithIcon {
                Layout.fillWidth: true
                materialIcon: "wallpaper"
                StyledToolTip {
                    content: Translation.tr("Pick wallpaper image on your system")
                }
                onClicked: {
                    Quickshell.execDetached(`${Directories.wallpaperSwitchScriptPath}`);
                }
                mainContentComponent: Component {
                    RowLayout {
                        spacing: 10
                        StyledText {
                            font.pixelSize: Appearance.font.pixelSize.small
                            text: Translation.tr("Choose file")
                            color: Appearance.colors.colOnSecondaryContainer
                        }
                        RowLayout {
                            spacing: 3
                            KeyboardKey {
                                key: "Ctrl"
                            }
                            KeyboardKey {
                                key: "󰖳"
                            }
                            StyledText {
                                Layout.alignment: Qt.AlignVCenter
                                text: "+"
                            }
                            KeyboardKey {
                                key: "T"
                            }
                        }
                    }
                }
            }
        }
    }
}
