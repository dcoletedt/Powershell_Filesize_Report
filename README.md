# 📂 FileSize Analyzer (PowerShell)

`FileSize Analyzer` es un script de PowerShell que escanea recursivamente una ruta de archivos en tu equipo, analiza su tamaño y genera un informe ordenado de mayor a menor. Incluye una **barra de progreso interactiva**, es **portátil** (no depende de rutas fijas), y permite al usuario elegir tanto la ruta a analizar como la de salida del reporte.

---

## 🎯 Objetivo

El propósito de este script es ayudar a identificar fácilmente qué archivos están ocupando más espacio en una carpeta, unidad o sistema completo, ideal para tareas como:

- Liberación de espacio en disco
- Auditorías de uso de almacenamiento
- Identificación de archivos grandes ocultos

---

## ⚙️ Funcionamiento

1. Solicita al usuario una ruta a analizar (por defecto, se usa la carpeta actual).
2. Solicita una ruta para guardar el archivo de salida (por defecto, se guarda en la carpeta temporal del sistema).
3. Escanea todos los archivos de la ruta, de forma **recursiva**.
4. Ordena los archivos por tamaño de mayor a menor.
5. Genera una barra de progreso visible en la consola mientras trabaja.
6. Guarda un archivo de texto con la lista de archivos y sus tamaños formateados (KB, MB, GB).

---

## 🛠 Requisitos

- PowerShell 5.1 o superior (compatible con PowerShell Core)
- Permisos de lectura sobre la ruta analizada
- Permisos de escritura sobre la ruta de salida

---

## 🚀 Ejecución

Desde PowerShell:

```powershell
.\filesize_analysis.ps1
