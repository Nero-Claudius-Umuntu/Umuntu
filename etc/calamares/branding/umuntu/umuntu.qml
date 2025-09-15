import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: root
    color: "#2d2d2d"
    
    Column {
        anchors.centerIn: parent
        spacing: 20
        
        Text {
            text: "Umuntu"
            font.pixelSize: 48
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Text {
            text: "Instalador del Sistema"
            font.pixelSize: 24
            color: "#cccccc"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Text {
            text: "Bienvenido al instalador de Umuntu.\n\nEste asistente te guiará a través del proceso de instalación."
            font.pixelSize: 16
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
