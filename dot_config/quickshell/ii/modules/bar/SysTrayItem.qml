import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets

MouseArea {
    id: root

    // offset of right-click menu position
    property point menuOffset: Qt.point(0, 0)
    property point menuPosition: Qt.point(root.x + menuOffset.x, root.y + menuOffset.y)
    property var bar: root.QsWindow.window
    required property SystemTrayItem item
    property bool targetMenuOpen: false
    readonly property bool useMonochromeIcons: Config.options.bar.tray.monochromeIcons

    enabled: true
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 20
    implicitHeight: 20
    onClicked: (event) => {
        switch (event.button) {
        case Qt.LeftButton:
            if (item.onlyMenu && item.hasMenu)
                menu.open();
            else
                item.activate();
            break;
        case Qt.RightButton:
            item.hasMenu && menu.open();
            break;
        }
        event.accepted = true;
    }
    onEntered: {
        tooltip.content = item.tooltipTitle.length > 0 ? item.tooltipTitle : (item.title.length > 0 ? item.title : item.id);
        if (item.tooltipDescription.length > 0)
            tooltip.content += " • " + item.tooltipDescription;

        if (Config.options.bar.tray.showItemId)
            tooltip.content += "\n[" + item.id + "]";

    }

    SysTrayItemPopup {
        id: tooltip

        item: root.item
        hoverTarget: root
    }

    IconImage {
        id: trayIcon

        visible: root.useMonochromeIcons
        source: root.item.icon
        anchors.centerIn: root
        implicitSize: root.width

        QsMenuAnchor {
            id: menu

            // anchor.edges: Config.options.bar.bottom ? (Edges.Top | Edges.Left) : (Edges.Bottom | Edges.Right)
            menu: root.item.menu
            // anchor.rect.x: root.x + (Config.options.bar.vertical ? 0 : root.bar?.width)
            // anchor.rect.y: root.y
            anchor.window: root.bar

            anchor.rect {
                x: root.menuPosition.x
                y: root.menuPosition.y
            }

        }

    }

    Loader {
        active: root.useMonochromeIcons
        anchors.fill: trayIcon

        sourceComponent: Item {
            Desaturate {
                id: desaturatedIcon

                visible: false // There's already color overlay
                anchors.fill: parent
                source: trayIcon
                desaturation: 0.8 // 1.0 means fully grayscale
            }

            ColorOverlay {
                anchors.fill: desaturatedIcon
                source: desaturatedIcon
                color: ColorUtils.transparentize(Appearance.colors.colOnLayer0, 0.9)
            }

        }

    }

}
