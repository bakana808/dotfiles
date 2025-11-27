import qs.services
import qs.modules.common.widgets
import qs.modules.common

// import QtQuick.Layouts

MaterialSymbol {
    // Layout.preferredWidth: iconSize
    // Layout.rightMargin: indicatorsRowLayout.realSpacing
    //
    iconSize: Appearance.sizes.icon
    color: ColorPalette.c3

    text: BluetoothStatus.connected ? "bluetooth_connected" : BluetoothStatus.enabled ? "bluetooth" : "bluetooth_disabled"
}
