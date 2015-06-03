/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import Material 0.1
import Material.Extras 0.1

/*!
   \qmltype Tooltip
   \inqmlmodule Material 0.1

   \brief A tooltip is a label that appears on hover and explains a non-text UI element.

   To display a tooltip for your view, simply create an instance of Tooltip, 
   set the text property to your tooltip text, and then set the mouseArea property
   to your MouseArea or Ink that will trigger the tooltip. If you use a MouseArea,
   make sure hoverEnabled is set to true.

   See the Material Design guidelines for more details: 
   http://www.google.com/design/spec/components/tooltips.html
 */
PopupBase {
    id: popover

    visible: view.opacity > 0

    property bool isBelow
    
    property alias backgroundColor: view.backgroundColor

    property int padding: Units.dp(16)

    default property alias data: view.data
    
    function open(caller, offsetX, offsetY) {
        parent = Utils.findRootChild(popover, overlayLayer)

        if (!parent.enabled)
            return

        if (parent.currentOverlay)
            parent.currentOverlay.close()

        if(typeof offsetX === "undefined")
            offsetX = 0

        if(typeof offsetY === "undefined")
            offsetY = 0

        var position = caller.mapToItem(popover.parent, 0, 0)
        var globalPos = caller.mapToItem(null, 0, 0)
        var root = Utils.findRoot(popover)

        popover.x = Qt.binding(function() {
            var x = position.x + (caller.width / 2 - popover.width / 2) + offsetX

            if(x + width > root.width - padding)
                x = root.width - width - padding

            if (x < padding)
                x = padding

            return x
        })

        popover.y = Qt.binding(function() {
            var y = y = position.y + caller.height + offsetY

            if (y + popover.height > root.height - padding) {
                isBelow = false
                y = position.y - popover.height - offsetY
            } else {
                isBelow = true
            }

            return y
        })        

        showing = true
        parent.currentOverlay = popover

        opened()
    }

    function close() {
        showing = false
        parent.currentOverlay = null
    }

    View {
        id: view

        elevation: 2
        radius: Units.dp(2)

        anchors {
            left: parent.left
            right: parent.right
            top: isBelow ? parent.top : undefined
            topMargin: popover.showing ? 0 : -popover.height/4
            bottom: !isBelow ? parent.bottom : undefined
            bottomMargin: popover.showing ? 0 : -popover.height/4

            Behavior on topMargin {
                NumberAnimation { duration: 200 }
            }

            Behavior on bottomMargin {
                NumberAnimation { duration: 200 }
            }
        }

        height: popover.height

        opacity: popover.showing ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }
}
