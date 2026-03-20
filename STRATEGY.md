# Estrategia de Automatización y Patrones

## 🎯 Alcance de la Estrategia
La automatización se diseñó para validar el ciclo de vida completo del recurso "Usuarios" en la API ServeRest, asegurando la integridad de los datos y la estabilidad de los endpoints principales (CRUD).

### Niveles de Prueba:
- **Pruebas de Componente:** Validación individual de cada método HTTP (GET, POST, PUT, DELETE).
- **Pruebas de Contrato:** Verificación de esquemas JSON para asegurar que la estructura de respuesta sea consistente.
- **Pruebas de Integración (E2E):** Flujo completo de creación, consulta, edición y eliminación de un usuario en una sola secuencia lógica.

## 🏗️ Patrones de Diseño Utilizados

### 1. Page Object Model (POM) - Adaptado a API
Dada la escala del proyecto, se optó por una estructura inspirada en POM donde cada endpoint tiene su propio archivo `.feature`. Esto permite:
- **Mantenibilidad:** Cambios en la lógica de un endpoint no afectan a los demás.
- **Legibilidad:** Escenarios claros y enfocados en una sola responsabilidad.

### 2. Caller / Reusable Helpers
Se implementó el patrón de **Caller** mediante `create-user-helper.feature`. 
- **Propósito:** Abstraer la creación de pre-condiciones.
- **Beneficio:** Los tests de `GET` by id, `PUT` y `DELETE` son independientes; no fallan si la base de datos está vacía porque ellos mismos gestionan su sujeto de prueba.

### 3. Data Driven Testing (DDT) Dinámico
En lugar de usar tablas estáticas, se integró un **Data Generator** en JavaScript.
- **Estrategia:** Generación de strings aleatorios para nombres y correos únicos.
- **Resultado:** Pruebas **idempotentes** que pueden ejecutarse infinitas veces sin colisión de datos.

## 🛠️ Gestión de Errores y Edge Cases
No solo se validaron los "Happy Paths". La estrategia incluyó:
- **Validación de tipos:** Asegurar que los IDs cumplan con el formato alfanumérico de 16 caracteres.
- **Manejo de Excepciones:** Verificación de respuestas 400 (Bad Request) vs 404 (Not Found) según las reglas de negocio de la API.

## 📈 Herramientas de Reportabilidad
Se utiliza el motor de reportes nativo de **Karate**, el cual permite una trazabilidad completa de cada request y response (incluyendo headers y payloads), facilitando el debugging en caso de fallos en el pipeline de CI.
