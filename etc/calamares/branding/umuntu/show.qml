import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Rectangle {
    id: root
    width: 800
    height: 600
    color: "#f5f5f5"

    property var slides: [
        {
            "title": "Bienvenido a Umuntu",
            "subtitle": "Nero Claudius Edition",
            "description": "Una distribución Linux temática basada en Ubuntu 24.04 LTS"
        },
        {
            "title": "Características Principales",
            "subtitle": "Tema Visual Completo",
            "description": "Fondos de pantalla, iconos personalizados, tema GRUB y más"
        },
        {
            "title": "Experiencia de Audio",
            "subtitle": "Efectos de Sonido Temáticos",
            "description": "Tema de audio personalizado 'Nero' para notificaciones"
        },
        {
            "title": "Configuraciones Personalizadas",
            "subtitle": "Burn-my-windows y GNOME Tweaks",
            "description": "Efectos de transición y configuraciones de shell personalizadas"
        }
    ]

    property int currentSlide: 0

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            currentSlide = (currentSlide + 1) % slides.length
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 50
        spacing: 30

        Image {
            id: logo
            source: "logo.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: title
            text: slides[currentSlide].title
            font.pixelSize: 32
            font.bold: true
            color: "#0068C8"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: subtitle
            text: slides[currentSlide].subtitle
            font.pixelSize: 24
            color: "#333333"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: description
            text: slides[currentSlide].description
            font.pixelSize: 16
            color: "#666666"
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        Item {
            Layout.fillHeight: true
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Repeater {
                model: slides.length
                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: index === currentSlide ? "#0068C8" : "#cccccc"
                }
            }
        }
    }
}
