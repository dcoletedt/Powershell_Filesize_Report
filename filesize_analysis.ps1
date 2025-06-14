# Script: AnalizarArchivosTamaño.ps1
# Descripción: Escanea una ruta seleccionada por el usuario y genera un informe de archivos ordenados por tamaño.

# Solicitar ruta a analizar
$rutaAnalisis = Read-Host "Introduce la ruta que deseas analizar (por defecto, se usará el directorio actual)"
if (-not $rutaAnalisis) {
    $rutaAnalisis = Get-Location
}

# Ruta del archivo de salida (en carpeta temporal o actual)
$defaultOutput = Join-Path -Path $env:TEMP -ChildPath "reporte_archivos_ordenados.txt"
$OutputFile = Read-Host "Introduce la ruta para guardar el reporte (por defecto: $defaultOutput)"
if (-not $OutputFile) {
    $OutputFile = $defaultOutput
}

# Función para ajustar el tamaño con la unidad más adecuada
function Ajustar-Tamaño {
    param ([long]$Bytes)
    if ($Bytes -ge 1GB) {
        return "{0:N2} GB" -f ($Bytes / 1GB)
    } elseif ($Bytes -ge 1MB) {
        return "{0:N2} MB" -f ($Bytes / 1MB)
    } elseif ($Bytes -ge 1KB) {
        return "{0:N2} KB" -f ($Bytes / 1KB)
    } else {
        return "$Bytes Bytes"
    }
}

# Mensaje inicial
Write-Output "Iniciando el análisis de la ruta: $rutaAnalisis..."

# Obtención de archivos
try {
    $archivos = Get-ChildItem -Path $rutaAnalisis -Recurse -File -ErrorAction SilentlyContinue
} catch {
    Write-Error "Error al intentar acceder a algunos archivos: $_"
    exit
}

# Ordenar por tamaño descendente
$archivosOrdenados = $archivos | Sort-Object Length -Descending

# Crear reporte con barra de progreso
$total = $archivosOrdenados.Count
$contador = 0
$lineasReporte = @()

foreach ($archivo in $archivosOrdenados) {
    $contador++
    $porcentaje = ($contador / $total) * 100

    Write-Progress -Activity "Generando reporte..." -Status "$contador de $total archivos" -PercentComplete $porcentaje

    $linea = "{0,-100} {1,10}" -f $archivo.FullName, (Ajustar-Tamaño $archivo.Length)
    $lineasReporte += $linea
}

# Guardar reporte
$lineasReporte | Out-File -FilePath $OutputFile -Encoding UTF8

Write-Output "✅ Reporte generado correctamente en: $OutputFile"