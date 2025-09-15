import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    color: "#2d2d2d"
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        
        Text {
            text: "Umuntu"
            font.pixelSize: 48
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
        
        Text {
            text: "Instalador del Sistema"
            font.pixelSize: 24
            color: "#cccccc"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
        
        Item {
            Layout.fillHeight: true
        }
        
        Text {
            text: "Bienvenido al instalador de Umuntu.\n\nEste asistente te guiará a través del proceso de instalación."
            font.pixelSize: 16
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
        
        Item {
            Layout.fillHeight: true
        }
    }
}
