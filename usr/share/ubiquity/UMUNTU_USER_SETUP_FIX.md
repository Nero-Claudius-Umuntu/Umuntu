# Umuntu - Corrección de Configuración de Usuarios y Hostname

## Problema Original

Ubiquity estaba copiando el usuario de la sesión live (ubuntu) en lugar de usar únicamente el usuario creado durante la instalación, y también estaba ignorando el nombre de máquina definido por el usuario.

## Solución Implementada

### 1. Script de Corrección (`fix-user-setup`)

Se creó un script bash que:
- Identifica el usuario creado durante la instalación
- Limpia configuraciones del usuario live que puedan haber sido copiadas
- Configura correctamente el hostname definido por el usuario
- Elimina el usuario live del sistema target si existe
- Actualiza `/etc/hosts` con el hostname correcto

### 2. Script de Copia de Wallpaper (`copy-wallpaper-config`)

Se creó un script especializado que:
- Copia configuraciones de GNOME del usuario live al usuario creado
- Incluye configuraciones de dconf, gsettings y archivos de GNOME
- Copia wallpapers personalizados y configuraciones de fondo de pantalla
- Copia configuraciones de cursor personalizado (incluyendo temas de cursor)
- Aplica configuraciones de gsettings automáticamente

### 3. Modificaciones en `plugininstall.py`

Se agregaron los siguientes métodos:
- `fix_user_and_hostname_setup()`: Se ejecuta al final del proceso de instalación
- `copy_gnome_wallpaper_settings()`: Copia configuraciones de wallpaper del usuario live
- `_copy_gnome_wallpaper_settings_fallback()`: Método alternativo si el script no está disponible
- `_copy_cursor_settings_fallback()`: Copia configuraciones de cursor personalizado

### 4. Mejoras en `copy_wallpaper_cache()`

Se modificó la función original para:
- Siempre copiar el wallpaper del usuario live al usuario creado
- Usar el script especializado para una copia más completa
- Incluir configuraciones adicionales de GNOME y wallpapers personalizados

### 5. Cambio del Hostname por Defecto

Se cambió el hostname por defecto de 'ubuntu' a 'umuntu' en la función `configure_network()`.

## Archivos Modificados

1. **`usr/share/ubiquity/fix-user-setup`** (nuevo)
   - Script principal de corrección
   - Ejecutable que maneja la limpieza de usuarios y configuración de hostname

2. **`usr/share/ubiquity/copy-wallpaper-config`** (nuevo)
   - Script especializado para copiar configuraciones de wallpaper
   - Maneja configuraciones de GNOME, dconf y wallpapers personalizados
   - Aplica configuraciones de gsettings automáticamente

3. **`usr/share/ubiquity/plugininstall.py`** (modificado)
   - Agregado método `fix_user_and_hostname_setup()`
   - Agregado método `copy_gnome_wallpaper_settings()`
   - Agregado método `_copy_gnome_wallpaper_settings_fallback()`
   - Modificado `copy_wallpaper_cache()` para copiar del usuario live
   - Modificado hostname por defecto a 'umuntu'
   - Agregada llamada al script de corrección

## Funcionamiento

1. Durante la instalación, Ubiquity procede normalmente
2. Durante la copia de configuraciones, se copia el wallpaper del usuario live al usuario creado
3. Al final del proceso (después de `save_random_seed()`), se ejecuta la corrección
4. El script identifica el usuario target y hostname definidos por el usuario
5. Se limpian configuraciones del usuario live
6. Se configura correctamente el hostname
7. Se elimina el usuario live del sistema instalado
8. Se aplican configuraciones de wallpaper y GNOME del usuario live al usuario creado

## Logs

Los procesos se registran en syslog con el prefijo "Umuntu:" para facilitar el debugging.

## Compatibilidad

- Compatible con instalaciones OEM (se omite en modo OEM)
- No interfiere con el proceso normal de instalación
- Funciona con cualquier hostname definido por el usuario
- Mantiene compatibilidad con funcionalidades existentes

## Beneficios

- El sistema instalado tendrá únicamente el usuario creado por el usuario final
- El hostname será exactamente el definido durante la instalación
- Se eliminan configuraciones residuales del usuario live
- El wallpaper y configuraciones visuales del usuario live se copian al usuario creado
- Se mantiene la personalización visual de Umuntu en el sistema instalado
- El cursor personalizado configurado con GNOME Tweaks se transfiere automáticamente
- Mejor experiencia de usuario al no tener usuarios o configuraciones no deseadas
- Configuraciones de GNOME, wallpapers y temas de cursor se preservan automáticamente
