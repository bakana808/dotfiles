import QtQuick

Text {
    id: root

    required property string name

    property real iconSize: Config.options.iconSize
    property bool fill: true
    property real truncatedFill: Math.round(fill * 100) / 100 // Reduce memory consumption spikes from constant font remapping

    text: root.name

    font {
        hintingPreference: Font.PreferFullHinting
        family: "Material Symbols Rounded"
        pixelSize: this.iconSize
        // weight: Font.Normal + (Font.DemiBold - Font.Normal) * fill
        styleName: "Bold"
        variableAxes: {
            "FILL": root.fill ? 1 : 0,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": 40
        }
    }
}
