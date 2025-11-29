//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma IconTheme hicolor

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import qs.modules.common
import qs.modules.background
import qs.modules.bar
import qs.modules.cheatsheet
import qs.modules.dock
import qs.modules.lock
import qs.modules.mediaControls
import qs.modules.notificationPopup
import qs.modules.onScreenDisplay
import qs.modules.onScreenKeyboard
import qs.modules.overview
import qs.modules.screenCorners
import qs.modules.sessionScreen
import qs.modules.sidebarLeft
import qs.modules.sidebarRight
import qs.modules.verticalBar
import qs.modules.wallpaperSelector
import qs.services

import QtQuick
import QtQuick.Window
import Quickshell

ShellRoot {
    id: root

    // Enable/disable modules here. False = not loaded at all, so rest assured
    // no unnecessary stuff will take up memory if you decide to only use, say, the overview.
    property bool enableBar: true
    property bool enableBackground: true
    property bool enableCheatsheet: true
    property bool enableDock: true
    property bool enableLock: true
    property bool enableMediaControls: true
    property bool enableNotificationPopup: true
    property bool enableOnScreenDisplayBrightness: true
    property bool enableOnScreenDisplayVolume: true
    property bool enableOnScreenKeyboard: false
    property bool enableOverview: true
    property bool enableReloadPopup: true
    property bool enableScreenCorners: true
    property bool enableSessionScreen: true
    property bool enableSidebarLeft: true
    property bool enableSidebarRight: true
    property bool enableVerticalBar: true
    property bool enableWallpaperSelector: true
    // Force initialization of some singletons
    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme();
        Hyprsunset.load();
        FirstRunExperience.load();
        ConflictKiller.load();
        Cliphist.refresh();
    }

    LazyLoader {
        active: root.enableBar && Config.ready && !Config.options.bar.vertical
        component: Bar {}
    }
    LazyLoader {
        active: root.enableBackground
        component: Background {}
    }
    LazyLoader {
        active: root.enableCheatsheet
        component: Cheatsheet {}
    }
    LazyLoader {
        active: root.enableDock && Config.options.dock.enable
        component: Dock {}
    }
    LazyLoader {
        active: root.enableLock
        component: Lock {}
    }
    LazyLoader {
        active: root.enableMediaControls
        component: MediaControls {}
    }
    LazyLoader {
        active: root.enableNotificationPopup
        component: NotificationPopup {}
    }
    LazyLoader {
        active: root.enableOnScreenDisplayBrightness
        component: OnScreenDisplayBrightness {}
    }
    LazyLoader {
        active: root.enableOnScreenDisplayVolume
        component: OnScreenDisplayVolume {}
    }
    LazyLoader {
        active: root.enableOnScreenKeyboard
        component: OnScreenKeyboard {}
    }
    LazyLoader {
        active: root.enableOverview
        component: Overview {}
    }
    LazyLoader {
        active: root.enableReloadPopup
        component: ReloadPopup {}
    }
    LazyLoader {
        active: root.enableScreenCorners
        component: ScreenCorners {}
    }
    LazyLoader {
        active: root.enableSessionScreen
        component: SessionScreen {}
    }
    LazyLoader {
        active: root.enableSidebarLeft
        component: SidebarLeft {}
    }
    LazyLoader {
        active: root.enableSidebarRight
        component: SidebarRight {}
    }
    LazyLoader {
        active: root.enableVerticalBar && Config.ready && Config.options.bar.vertical
        component: VerticalBar {}
    }
    LazyLoader {
        active: root.enableWallpaperSelector
        component: WallpaperSelector {}
    }
}
