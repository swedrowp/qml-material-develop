/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Jordan Neidlinger
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
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import Material 0.1

/*!
   \qmltype RadioButton
   \inqmlmodule Material 0.1

   \brief Radio buttons allow the user to select one option from a set.
*/
Controls.RadioButton {
    id: radioButton

    /*!
       The switch color. By default this is the app's accent color
     */
    property color color: darkBackground ? Theme.dark.accentColor
                                         : Theme.light.accentColor

    /*!
       Set to \c true if the switch is on a dark background
     */
    property bool darkBackground

    /*!
       Set to \c true if the radio button can be toggled from checked to unchecked
     */
    property bool canToggle

    style: MaterialStyle.RadioButtonStyle {}

    Ink {
        id: inkArea
        anchors {
            left: parent.left
            leftMargin: Units.dp(4)
            verticalCenter: parent.verticalCenter
        }

        width: Units.dp(40)
        height: Units.dp(40)
        color: radioButton.checked ? Theme.alpha(radioButton.color, 0.20) : Qt.rgba(0,0,0,0.1)

        onClicked: {
            if(radioButton.canToggle || !radioButton.checked)
                radioButton.checked = !radioButton.checked
        }

        circular: true
        centered: true
    }

    MouseArea {
        anchors {
            left: inkArea.right
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        onClicked: {
            if(radioButton.canToggle || !radioButton.checked)
                radioButton.checked = !radioButton.checked
        }
    }
}
