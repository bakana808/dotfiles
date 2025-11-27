import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    property color textColor: "white"
    property real textSize: Appearance.font.pixelSize.smaller

    property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
    property bool focusingThisMonitor: HyprlandData.activeWorkspace?.monitor == monitor?.name
    property var biggestWindow: HyprlandData.biggestWindowForWorkspace(HyprlandData.monitors[root.monitor?.id]?.activeWorkspace.id)

    implicitWidth: colLayout.implicitWidth

    ColumnLayout {
        id: colLayout

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: -4

        // process name
        // StyledText {
        //     Layout.fillWidth: true
        //     font.pixelSize: Appearance.font.pixelSize.smaller
        //     color: Appearance.colors.colSubtext
        //     elide: Text.ElideRight
        //     text: root.focusingThisMonitor && root.activeWindow?.activated && root.biggestWindow ?
        //         root.activeWindow?.appId :
        //         (root.biggestWindow?.class) ?? Translation.tr("Desktop")
        //
        // }

        // process title
        StyledText {
            Layout.fillWidth: true
            font.pixelSize: root.textSize
            color: root.textColor
            elide: Text.ElideRight
            text: {
                if (root.focusingThisMonitor) {
                    if (root.activeWindow?.activated && root.biggestWindow)
                        return root.activeWindow?.title;
                    return "";
                }
                return (root.biggestWindow?.title) ?? `${Translation.tr("Workspace")} ${root.monitor?.activeWorkspace?.id ?? 1}`;
            }
        }
    }
}
