import qs.modules.common
import qs.modules.common.widgets
import qs.services

import QtQuick
import QtQuick.Layouts

MouseArea {
    id: root

    property real iconSize: Appearance.sizes.icon
    property string iconColor: ColorPalette.c4

    implicitWidth: rowLayout.width
    implicitHeight: rowLayout.height

    hoverEnabled: true

    RowLayout {
        id: rowLayout

        MaterialSymbol {
            id: icon

            text: Network.materialSymbol
            color: root.iconColor
            iconSize: root.iconSize
        }
        StyledText {
            id: strengthText

            visible: Network.wifiEnabled && Network.networkName
            text: Network.networkName
            font: Appearance.fonts.bar
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
