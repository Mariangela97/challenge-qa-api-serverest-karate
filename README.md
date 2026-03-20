# challenge-qa-api-serverest-karate
API Automation Suite for ServeRest users management using Karate DSL

# API Automation Challenge - ServeRest 

Este proyecto contiene una suite de pruebas automatizadas para la API de Usuarios de **ServeRest**, desarrollada utilizando **Karate DSL**.

## 🚀 Instrucciones de Ejecución

### Requisitos Previos
* Java JDK 17 o superior.
* Maven instalado y configurado en las variables de entorno.

### Instalar dependencias (limpiar, descargar y compilar):
```bash
mvn clean install -DskipTests
```

### Ejecutar la Suite Completa
Para ejecutar todas las pruebas y generar los reportes de Karate, abre una terminal en la raíz del proyecto y ejecuta el comando de prueba de Maven.
```bash
mvn test
```

## 📊 Reportes de Pruebas

Karate genera automáticamente reportes interactivos en formato HTML. Una vez finalizada la ejecución, puedes ver los resultados detallados en la carpeta de salida de build de Maven, específicamente en el archivo de sumario de reportes de Karate.
```bash
target/karate-reports/karate-summary.html
```
