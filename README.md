# 🌹 Umuntu - Nero Claudius Edition

[English Version](README_EN.md) | [Versión en Español](README.md)

> *"Umu! ¡Qué hermoso es este sistema!"* - Nero Claudius

Una distribución Linux temática basada en Ubuntu 24.04 LTS, completamente personalizada con el tema de **Nero Claudius** de la serie Fate/Extra. Una experiencia de usuario única que combina la estabilidad de Ubuntu con la elegancia imperial de la Emperatriz de Roma.

## ✨ Características Principales

### 🎨 **Tema Visual Completo**
- **Fondos de pantalla**: Más de 40 wallpapers exclusivos de Nero Claudius
- **Iconos personalizados**: Sets de cursores temáticos (Nero-Black, Nero-Dark, Nero-Red, Nero-White)
- **Tema GRUB**: Bootloader personalizado con fondo temático
- **Plymouth**: Pantallas de arranque con el logo de Umuntu
- **Neofetch**: ASCII art personalizado de Nero

### 🔊 **Experiencia de Audio**
- **Efectos de sonido**: Tema de audio personalizado "Nero" para notificaciones y eventos del sistema
- **Sonidos de arranque**: Audio temático al iniciar el sistema

### 🖼️ **Fondos de Pantalla**
- Nero en diferentes poses y situaciones
- Variantes de Nero Bride
- Escenas de batalla y descanso
- Arte de la comunidad de Fate/Extra
- Fondos de video animados

### ⚙️ **Configuraciones Personalizadas**
- **Burn-my-windows**: Efectos de transición temáticos
- **GNOME Tweaks**: Configuraciones de shell personalizadas
- **Thumbnailers**: Soporte para archivos STL y cursores X11

## 🚀 Instalación

### Prerrequisitos
- Ubuntu 24.04 LTS como base
- Linux Live Kit
- Calamares Installer
- Al menos 4GB de RAM
- 20GB de espacio libre en disco

### Proceso de Construcción
1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/Umuntu.git
   cd Umuntu
   ```

2. **Preparar el entorno**:
   ```bash
   # Instalar dependencias necesarias
   sudo apt update
   sudo apt install linux-live calamares
   ```

3. **Construir la ISO**:
   ```bash
   # Ejecutar el script de construcción (próximamente)
   ./build-umuntu.sh
   ```

## 📁 Estructura del Proyecto

```
Umuntu/
├── boot/grub/                    # Configuración del bootloader
│   ├── themes/umuntu/           # Tema GRUB personalizado
│   └── fonts/                   # Fuentes para GRUB
├── usr/share/
│   ├── backgrounds/             # Fondos de pantalla de Nero
│   │   ├── video/              # Fondos animados
│   │   └── contest/            # Fondos adicionales
│   ├── icons/                  # Iconos y cursores temáticos
│   │   ├── Nero-Black/
│   │   ├── Nero-Dark/
│   │   ├── Nero-Red/
│   │   └── Nero-White/
│   ├── sounds/Nero/            # Efectos de sonido temáticos
│   ├── plymouth/themes/        # Pantallas de arranque
│   └── neofetch/               # ASCII art personalizado
├── config/                     # Configuraciones de aplicaciones
│   ├── neofetch/
│   └── burn-my-windows/
├── etc/                        # Configuraciones del sistema
└── Extras/                     # Scripts y utilidades adicionales
```

## 🎯 Características Técnicas

- **Base**: Ubuntu 24.04.3 LTS (Noble Numbat)
- **Entorno de Escritorio**: GNOME (personalizado)
- **Kernel**: Linux 6.14.0-29-generic
- **Arquitectura**: x86_64
- **Tamaño estimado**: ~2.5GB (ISO)

## 🛠️ Herramientas de Desarrollo

### Scripts Incluidos
- **Thumbnailers**: Soporte para archivos STL y cursores X11
- **Configuraciones**: Scripts de automatización para aplicaciones

### Personalización
- **Logo**: SVG personalizado de Umuntu
- **Temas**: Configuraciones CSS para GNOME Shell
- **Sonidos**: Índices de temas de audio personalizados

## 🎨 Galería de Capturas

*[Aquí irían las capturas de pantalla del sistema]*

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Si tienes ideas para mejorar la experiencia temática:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## ⚠️ Disclaimer

Este es un proyecto de pasatiempo y no está afiliado oficialmente con:
- Type-Moon
- Fate/Extra
- Ubuntu/Canonical
- Cualquier otra entidad comercial

Todos los derechos de los personajes pertenecen a sus respectivos propietarios.

## 🎭 Sobre Nero Claudius

Nero Claudius Caesar Augustus Germanicus, conocida simplemente como Nero, es una Servant de clase Saber en Fate/Extra. Como la quinta emperatriz del Imperio Romano, es conocida por su personalidad extravagante, su amor por el arte y su frase característica "Umu!".

## 📞 Contacto

- **Proyecto**: [GitHub Repository](https://github.com/tu-usuario/Umuntu)
- **Issues**: [GitHub Issues](https://github.com/tu-usuario/Umuntu/issues)

---

*"¡Umu! ¡Qué hermoso es este sistema! ¡Es digno de una emperatriz como yo!"* 🌹

---

**Nota**: Este repositorio contiene solo los archivos modificados para mantener el tamaño bajo los límites de GitHub. Para una instalación completa, se requiere una base de Ubuntu 24.04 LTS.
