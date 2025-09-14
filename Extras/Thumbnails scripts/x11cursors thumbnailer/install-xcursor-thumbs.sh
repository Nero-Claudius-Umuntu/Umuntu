#!/usr/bin/env bash
set -e

echo "=== Instalando dependencias ==="
sudo apt update
sudo apt install -y git build-essential libpng-dev libxcursor-dev imagemagick

echo "=== Verificando xcur2png ==="
if ! command -v xcur2png &>/dev/null; then
    echo "No se encontró xcur2png. Compilando desde el código..."
    git clone https://github.com/eworm-de/xcur2png.git /tmp/xcur2png
    cd /tmp/xcur2png
    gcc -o xcur2png xcur2png.c -lpng -lXcursor
    sudo mv xcur2png /usr/local/bin/
    cd ~
    rm -rf /tmp/xcur2png
else
    echo "xcur2png ya está instalado."
fi

echo "=== Creando script de conversión ==="
sudo tee /usr/local/bin/xcursorthumbs >/dev/null <<'EOF'
#!/usr/bin/env bash
TEMP=$(mktemp --directory --tmpdir tumbler-xcur-XXXXXX) || exit 1
if xcur2png -d "$TEMP" -q -c - "$1" >/dev/null 2>&1; then
    convert -thumbnail "$3" "$TEMP"/*_000.png "$2" >/dev/null 2>&1
fi
rm -rf "$TEMP"
EOF
sudo chmod +x /usr/local/bin/xcursorthumbs

echo "=== Creando archivo thumbnailer ==="
sudo tee /usr/share/thumbnailers/xcusrsor.thumbnailer >/dev/null <<'EOF'
[Thumbnailer Entry]
Version=1.0
Encoding=UTF-8
Type=X-Thumbnailer
Name=Xcursor Thumbnailer
MimeType=image/x-xcursor;
Exec=/usr/local/bin/xcursorthumbs %i %o %s
EOF

echo "=== Registrando MIME type ==="
sudo tee /usr/share/mime/packages/x-xcursor.xml >/dev/null <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
    <mime-type type="image/x-xcursor">
        <comment>X11 cursor file</comment>
        <glob pattern="*.cursor"/>
        <glob pattern="*"/>
    </mime-type>
</mime-info>
EOF

sudo update-mime-database /usr/share/mime

echo "=== Limpiando caché de thumbnails ==="
rm -rf ~/.cache/thumbnails/*

echo "=== Reiniciando servicio de thumbnails ==="
if systemctl --user is-active --quiet tumblerd.service; then
    systemctl --user restart tumblerd.service
elif pgrep tumblerd &>/dev/null; then
    pkill tumblerd
    tumblerd &
else
    echo "No se detectó tumblerd corriendo, iniciando..."
    tumblerd &
fi

echo "=== Proceso completado ==="
echo "Ahora los thumbnails de cursores deberían funcionar tanto en GNOME como en Budgie."
