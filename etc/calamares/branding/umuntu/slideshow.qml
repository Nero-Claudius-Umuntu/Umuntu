import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: root
    color: "#1a1a1a"
    
    // Fondo con gradiente sutil
    Rectangle {
        anchors.fill: parent
        color: "#2d2d2d"
        opacity: 0.3
    }
    
    Column {
        anchors.centerIn: parent
        spacing: 25
        
        Text {
            text: "Umuntu"
            font.pixelSize: 52
            font.bold: true
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            style: Text.Outline
            styleColor: "#000000"
        }
        
        Text {
            text: "Instalador del Sistema"
            font.pixelSize: 26
            font.bold: true
            color: "#ff6b6b"
            anchors.horizontalCenter: parent.horizontalCenter
            style: Text.Outline
            styleColor: "#000000"
        }
        
        Rectangle {
            width: parent.width
            height: 2
            color: "#ff6b6b"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.7
        }
        
        Text {
            text: "Bienvenido al instalador de Umuntu.\n\nEste asistente te guiará a través del proceso de instalación."
            font.pixelSize: 18
            color: "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            style: Text.Outline
            styleColor: "#000000"
            wrapMode: Text.WordWrap
            width: 400
        }
    }
}
