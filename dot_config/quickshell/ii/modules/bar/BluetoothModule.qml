import QtQuick.Layouts

import qs.services
import qs.modules.common.widgets
import qs.modules.common

MaterialSymbol {
    Layout.fillHeight: true

    iconSize: Appearance.sizes.icon
    color: ColorPalette.c3

    text: BluetoothStatus.connected ? "bluetooth_connected" : BluetoothStatus.enabled ? "bluetooth" : "bluetooth_disabled"
}
