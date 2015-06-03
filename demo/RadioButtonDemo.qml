import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2 as QuickControls
import Material 0.1

ColumnLayout {
    spacing: 0

    Repeater {
        model: 2

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: grid.height + Units.dp(80)
            Layout.minimumWidth: grid.width + Units.dp(80)
            color: index == 0 ? "#EEE" : "#333"

            GridLayout {
                id: grid
                anchors.centerIn: parent
                rowSpacing: Units.dp(20)
                columnSpacing: Units.dp(20)
                columns: 2

                QuickControls.ExclusiveGroup { id: optionGroup }

                Label {
                    Layout.alignment : Qt.AlignHCenter
                    text: "Normal"
                    color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                }

                Label {
                    Layout.alignment : Qt.AlignHCenter
                    text: "Disabled"
                    color: index == 0 ? Theme.light.textColor : Theme.dark.textColor
                }

                RadioButton {
                    checked: true
                    text: "Option 1"
                    darkBackground: index == 1
                    canToggle: true
                    exclusiveGroup: optionGroup
                }

                RadioButton {
                    checked: true
                    enabled: false
                    text: "Disabled"
                    darkBackground: index == 1
                }

                RadioButton {
                    text: "Option 2"
                    darkBackground: index == 1
                    canToggle: true
                    exclusiveGroup: optionGroup
                }

                RadioButton {
                    enabled: false
                    text: "Disabled"
                    darkBackground: index == 1
                }
            }
        }
    }
}
