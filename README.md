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

# Verificación de la Base de Datos `AIRBNB_DB`

Este documento contiene una serie de consultas SQL para verificar el correcto funcionamiento de la base de datos `AIRBNB_DB`. Las consultas permiten validar la estructura y relaciones entre las tablas principales, asegurando que la información almacenada sea accesible y consistente.

---

## 1. Listar todos los usuarios registrados

Esta consulta recupera todos los registros de la tabla `Users`, mostrando la información de los usuarios registrados en la plataforma.

```sql
SELECT  FROM Users;
```

---

## 2. Contar la cantidad de lugares registrados

Esta consulta devuelve el número total de lugares almacenados en la base de datos.

```sql
SELECT COUNT() AS total_places FROM Place;
```

---

## 3. Obtener los nombres de los lugares y sus ciudades

Consulta que une las tablas `Place` y `City` para mostrar los nombres de los lugares junto con la ciudad en la que se encuentran.

```sql
SELECT p.name AS place_name, c.name AS city_name
FROM Place p
JOIN City c ON p.city_id = c.id;
```

---

## 4. Mostrar todas las reseñas con información del usuario y el lugar reseñado

Esta consulta recupera todas las reseñas, incluyendo el texto de la reseña, el nombre del usuario que la realizó y el nombre del lugar reseñado.

```sql
SELECT r.text AS review, u.first_name  ' '  u.last_name AS reviewer, p.name AS place_name
FROM Review r
JOIN Users u ON r.user_id = u.id
JOIN Place p ON r.place_id = p.id;
```

---

## 5. Contar cuántos lugares tiene cada usuario

Consulta que muestra la cantidad de lugares registrados por cada usuario en la plataforma.

```sql
SELECT u.first_name  ' '  u.last_name AS user_name, COUNT(p.id) AS total_places
FROM Users u
LEFT JOIN Place p ON u.id = p.user_id
GROUP BY u.id, u.first_name, u.last_name;
```

---

## 6. Listar todas las ciudades y su respectivo estado

Esta consulta une las tablas `City` y `State` para mostrar las ciudades junto con el estado al que pertenecen.

```sql
SELECT c.name AS city_name, s.name AS state_name
FROM City c
JOIN State s ON c.state_id = s.id;
```

---

## 7. Mostrar los lugares con su precio por noche ordenados de mayor a menor

Consulta que lista los lugares disponibles junto con su precio por noche, ordenados del más caro al más barato.

```sql
SELECT name, price_by_night
FROM Place
ORDER BY price_by_night DESC;
```

---

## 8. Obtener los lugares que tienen más de 2 habitaciones y más de 1 baño

Esta consulta filtra los lugares que tienen más de dos habitaciones y al menos dos baños.

```sql
SELECT name, number_rooms, number_bathrooms
FROM Place
WHERE number_rooms  2 AND number_bathrooms  1;
```

---

## 9. Verificar qué amenidades están registradas

Consulta para listar todas las amenidades disponibles en la base de datos.

```sql
SELECT  FROM Amenity;
```

---

## 10. Obtener los lugares que tienen reseñas

Esta consulta muestra los nombres de los lugares que han recibido al menos una reseña.

```sql
SELECT DISTINCT p.name AS place_name
FROM Place p
JOIN Review r ON p.id = r.place_id;
```

---

Con estas consultas, se puede validar que la base de datos `AIRBNB_DB` está correctamente estructurada y que las relaciones entre sus entidades están funcionando de manera adecuada.
