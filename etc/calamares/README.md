# Configuración de Calamares para Umuntu

Este directorio contiene toda la configuración necesaria para el instalador Calamares de la distribución Umuntu.

## Estructura de Archivos

### Archivo Principal
- `settings.conf` - Configuración principal de Calamares con la secuencia de módulos

### Branding (`branding/umuntu/`)
- `branding.desc` - Configuración de branding (nombres, URLs, colores)
- `umuntu.qml` - Slideshow personalizado durante la instalación
- `slideshow.qml` - Archivo de slideshow (copia de umuntu.qml)
- `style.css` - Estilos CSS personalizados
- `logo.png` - Logo de Umuntu
- `splash.png` - Imagen de bienvenida

### Módulos (`modules/`)
- `welcome/welcome.conf` - Configuración de la página de bienvenida
- `partition/partition.conf` - Configuración del particionado de disco
- `users/users.conf` - Configuración de creación de usuarios
- `summary/summary.conf` - Configuración de la página de resumen
- `mount/mount.conf` - Configuración del montaje de sistemas de archivos
- `unpackfs/unpackfs.conf` - Configuración de extracción de la imagen del sistema
- `packages/packages.conf` - Configuración de instalación de paquetes
- `install/install.conf` - Configuración adicional de instalación

## Secuencia de Instalación

1. **Welcome** - Página de bienvenida con información del sistema
2. **Partition** - Configuración de particiones de disco
3. **Users** - Creación de usuarios del sistema
4. **Summary** - Resumen de la configuración antes de instalar
5. **Mount** - Montaje del sistema de archivos objetivo
6. **Unpackfs** - Extracción de la imagen del sistema
7. **Packages** - Instalación de paquetes adicionales

## Instalación

Para usar esta configuración, copia todo el contenido de este directorio a `/etc/calamares/`:

```bash
sudo cp -r etc/calamares/* /etc/calamares/
```

También copia el branding a la ubicación del sistema:

```bash
sudo cp -r etc/calamares/branding/umuntu /usr/share/calamares/branding/
```

## Personalización

- **Branding**: Modifica `branding/umuntu/branding.desc` para cambiar nombres, URLs y colores
- **Slideshow**: Edita `branding/umuntu/umuntu.qml` para personalizar la pantalla durante la instalación
- **Módulos**: Cada módulo tiene su propio archivo de configuración en `modules/`
- **Secuencia**: La secuencia de módulos se define en `settings.conf`

## Notas

- Esta configuración está optimizada para distribuciones basadas en Ubuntu/Debian
- El módulo `unpackfs` requiere que exista una imagen del sistema en `/cdrom/casper/filesystem.squashfs`
- Los colores del branding siguen el esquema de colores de Umuntu (#2d2d2d, #ff6b6b)
