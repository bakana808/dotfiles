import qs.modules.common
import qs.modules.common.widgets
import qs.services

import QtQuick
import QtQuick.Layouts

MouseArea {
    id: root

    readonly property font font: Appearance.fonts.bar
    property real iconSize: Appearance.sizes.icon
    property string iconColor: ColorPalette.c4

    Layout.fillHeight: true

    implicitWidth: rowLayout.implicitWidth

    hoverEnabled: true

    RowLayout {
        id: rowLayout

        height: root.height

        MaterialSymbol {
            id: icon

            Layout.fillHeight: true
            text: Network.materialSymbol
            color: root.iconColor
            iconSize: root.iconSize

            MaterialSymbol {
                anchors.fill: parent
                text: "wifi"
                color: root.iconColor
                opacity: 0.25
                iconSize: root.iconSize
            }
        }

        StyledText {
            id: strengthText

            visible: Network.wifiEnabled && Network.networkName && Network.networkName != "lo"
            text: Network.networkName
            font: root.font
            color: root.iconColor
            verticalAlignment: Text.AlignVCenter
        }
    }

    StyledPopup {
        id: popup

        hoverTarget: root

        ColumnLayout {
            id: popupLines

            anchors.centerIn: parent
            spacing: 4

            // network name
            StyledText {
                text: {
                    var name = "";
                    if (Network.wifi || Network.ethernet)
                        name = Network.networkName;

                    if (name)
                        return `Connected to: ${name}`;
                    else
                        return "No connection";
                }
            }

            // network strength
            StyledText {
                text: {
                    var strength = Network.wifiEnabled && Network.networkName ? Network.networkStrength : -1;
                    if (strength === -1)
                        return "Network Strength: N/A";
                    else
                        return `Network Strength: ${strength}%`;
                }
            }
        }
    }
}
