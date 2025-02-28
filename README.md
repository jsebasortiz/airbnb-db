# Creación y Configuración de la Base de Datos AIRBNB_DB

## Descripción
Este script SQL permite la creación y configuración de la base de datos `AIRBNB_DB`, que es utilizada para gestionar información sobre usuarios, lugares, ciudades, estados, reseñas y amenidades en una plataforma similar a Airbnb. 

## Características del Script
- Creación del usuario `AIRBNB_DB` con permisos adecuados.
- Eliminación de tablas y secuencias existentes para evitar conflictos.
- Creación de tablas y secuencias necesarias para la estructura de datos.
- Definición de claves foráneas y índices para optimización.
- Inserción de datos iniciales de ejemplo.

## Requisitos Previos
- Servidor de base de datos Oracle.
- Acceso con privilegios suficientes para crear usuarios y tablas.
- Habilitación de `DBMS_OUTPUT` para visualizar mensajes de salida.

## Instrucciones de Uso
1. Conéctate a Oracle SQL Plus o cualquier herramienta compatible.
2. Ejecuta el script en el orden en que está estructurado.
3. Verifica la correcta creación de las tablas y datos utilizando consultas `SELECT`.

## Estructura de la Base de Datos
### Tablas Principales
- **Users**: Información de usuarios registrados.
- **Place**: Lugares disponibles para renta.
- **City**: Ciudades donde se encuentran los lugares.
- **State**: Estados o regiones de las ciudades.
- **Review**: Reseñas de los lugares.
- **Amenity**: Amenidades disponibles (WiFi, Piscina, etc.).
- **PlaceAmenity**: Relación entre lugares y amenidades.

### Claves Foráneas
- `Place.user_id` → `Users.id`
- `Place.city_id` → `City.id`
- `City.state_id` → `State.id`
- `Review.user_id` → `Users.id`
- `Review.place_id` → `Place.id`
- `PlaceAmenity.amenity_id` → `Amenity.id`
- `PlaceAmenity.place_id` → `Place.id`

## Datos de Ejemplo
- Estados: Antioquia, Cundinamarca.
- Ciudades: Medellín, Bogotá.
- Usuarios: Juan Pérez, Maria González.
- Lugares: Apartamento en Medellín, Casa en Bogotá.
- Reseñas: "Gran lugar, muy limpio y bien ubicado."

## Notas
- La contraseña del usuario `AIRBNB_DB` en el script está configurada como `12345678`. Es recomendable cambiarla por razones de seguridad.
- Si el usuario o las tablas ya existen, el script maneja su eliminación previa para evitar conflictos.

## Autor
Juan Sebastian Ortiz (230202011)
