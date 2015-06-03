/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
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

/*!
   \qmltype Tabs
   \inqmlmodule Material 0.1
   \internal

   \brief Provides a tab bar for use in the toolbar.
 */
Row {
    id: tabbar

    property var tabs: []
    property int selectedIndex: 0

    property bool darkBackground

    property color color: darkBackground ? Theme.dark.textColor : Theme.light.textColor
    property color highlightColor: Theme.tabHighlightColor
    property color textColor: darkBackground ? Theme.dark.textColor : Theme.light.accentColor

    height: Units.dp(48)

    Repeater {
        id: repeater
        model: tabbar.tabs

        delegate: View {
            id: tabItem
            width:Units.dp(48) + row.width
            height: tabbar.height

            property bool selected: index == tabbar.selectedIndex

            Ink {
                anchors.fill: parent

                onClicked: tabbar.selectedIndex = index
            }

            Rectangle {
                id: selectionIndicator
                anchors {
                    bottom: parent.bottom
                }

                height: Units.dp(2)
                color: tabbar.highlightColor
                opacity: tabItem.selected ? 1 : 0
                //x: index < tabbar.selectedIndex ? tabItem.width : 0
                //width: index == tabbar.selectedIndex ? tabItem.width : 0
                width: parent.width

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }

                Behavior on x {
                    NumberAnimation { duration: 200 }
                }

                Behavior on width {
                    NumberAnimation { duration: 200 }
                }
            }

            Row {
                id: row

                anchors.centerIn: parent
                spacing: Units.dp(10)

                Icon {
                    anchors.verticalCenter: parent.verticalCenter

                    name: modelData.hasOwnProperty("icon") ? modelData.icon : ""
                    color: tabItem.selected 
                            ? darkBackground ? Theme.dark.iconColor : Theme.light.accentColor
                            : darkBackground ? Theme.dark.shade(0.6) : Theme.light.shade(0.6)

                    visible: name != ""

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }

                Label {
                    id: label

                    text: modelData.hasOwnProperty("text") ? modelData.text : modelData
                    color: tabItem.selected
                            ? darkBackground ? Theme.dark.textColor : Theme.light.accentColor
                            : darkBackground ? Theme.dark.shade(0.6) : Theme.light.shade(0.6)

                    style: "body2"
                    font.capitalization: Font.AllUppercase
                    anchors.verticalCenter: parent.verticalCenter

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }
            }
        }
    }
}
