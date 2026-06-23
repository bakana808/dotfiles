pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property string path: Qt.resolvedUrl("./config.json")
    property alias options: fileJsonAdapter
    property var colors: Wal.colors

    FileView {
        path: root.path
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        // qmllint disable unresolved-type
        JsonAdapter {
            id: fileJsonAdapter

            property bool dark: true

            property real iconSize: 16.0

            property font fontNormal: ({
                    family: "Roboto Mono",
                    bold: true,
                    pixelSize: 11
                })

            property string fontColor: Wal.foreground

            property var bar: ({
                    height: 30,
                    margin: 10,
                    color: Wal.background
                })
        }
    }
}
