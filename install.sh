#!/bin/bash

# ===============================================
# Configuración del Repositorio (¡MODIFICA ESTO!)
# ===============================================
# Enlace base al contenido RAW de tu repositorio (¡Asegúrate de que la rama es correcta!)
GITHUB_RAW_BASE="https://raw.githubusercontent.com/thefather12/ADM-FATHER/main"

# La ruta de las carpetas DENTRO de tu repositorio, empezando por la raíz.
# Asumiendo que el contenido principal está en /WEBSOCKETMOD/FATHER/
PROJECT_ROOT="WEBSOCKETMOD/FATHER" 
SCRIPT_NAME="vps-proxy.sh"
COMMAND_NAME="vpsproxy"

# DIRECTORIO DE INSTALACIÓN FINAL EN EL SERVIDOR (MODIFICADO)
INSTALL_DIR="/etc/FATHER"

# -----------------------------------------------
# Archivos a descargar y su ubicación final
# -----------------------------------------------
declare -A FILES=(
    ["${PROJECT_ROOT}/${SCRIPT_NAME}"]="${INSTALL_DIR}/${SCRIPT_NAME}"
    ["${PROJECT_ROOT}/protocols/funcoes.sh"]="${INSTALL_DIR}/protocols/funcoes.sh"
    ["${PROJECT_ROOT}/protocols/PPub.py"]="${INSTALL_DIR}/protocols/PPub.py"
    ["${PROJECT_ROOT}/protocols/PPriv.py"]="${INSTALL_DIR}/protocols/PPriv.py"
    ["${PROJECT_ROOT}/protocols/POpen.py"]="${INSTALL_DIR}/protocols/POpen.py"
    ["${PROJECT_ROOT}/protocols/PGet.py"]="${INSTALL_DIR}/protocols/PGet.py"
)

# ===============================================
# PROCESO DE INSTALACIÓN
# ===============================================

echo "--- Iniciando Instalación de FATHER Proxy ---"
echo "URL Base: ${GITHUB_RAW_BASE}"

# 1. Crear directorios de instalación si no existen
echo "Creando estructura de directorios en ${INSTALL_DIR}..."
mkdir -p ${INSTALL_DIR}/protocols
mkdir -p ${INSTALL_DIR}/tools 

# 2. Descargar archivos y colocarlos en la ruta final
for src_path in "${!FILES[@]}"; do
    dest_path="${FILES[${src_path}]}"
    url="${GITHUB_RAW_BASE}/${src_path}"
    
    echo "  -> Descargando $(basename "${src_path}") a $(dirname "${dest_path}")"
    
    # Usa wget o curl, lo que esté disponible en el sistema
    if command -v wget >/dev/null; then
        wget -q --no-check-certificate -O "${dest_path}" "${url}"
    elif command -v curl >/dev/null; then
        curl -s -k -o "${dest_path}" "${url}"
    else
        echo -e "\nERROR: No se encontró 'wget' ni 'curl'. No se puede continuar."
        exit 1
    fi

    # Verificar si la descarga fue exitosa (solo para el archivo principal)
    if [[ "${src_path}" == *"${SCRIPT_NAME}"* ]] && [ ! -s "${dest_path}" ]; then
        echo -e "\nERROR: Falló la descarga de ${SCRIPT_NAME} (Comprueba las variables GITHUB_RAW_BASE y PROJECT_ROOT)."
        exit 1
    fi
done

# 3. Mover y enlazar el script principal para que sea un comando
echo "Configurando el comando '/usr/local/bin/${COMMAND_NAME}'..."
chmod +x "${INSTALL_DIR}/${SCRIPT_NAME}"
# Crea un enlace simbólico para poder ejecutar el comando desde cualquier lugar
ln -sf "${INSTALL_DIR}/${SCRIPT_NAME}" "/usr/local/bin/${COMMAND_NAME}"

echo -e "\n--- ¡INSTALACIÓN COMPLETA! ---"
echo "El comando ha sido instalado como: ${COMMAND_NAME}"
echo "Ahora puede ejecutar: ${COMMAND_NAME}"
