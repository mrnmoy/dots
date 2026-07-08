import qs.components.effects
import qs.services
import qs.utils
import qs.config
import Quickshell.Widgets

IconImage {
    source: SysInfo.osLogo
    implicitSize: Appearance.font.size.large * 1.2

    layer.enabled: true
    layer.effect: Colouriser {
        colorizationColor: Colours.palette.m3tertiary
    }
}
