# Gestor de tareas

Aplicación React + Vite basada en el prototipo Figma Make. Permite crear tareas con título, descripción y estado, filtrar por estado, actualizar y eliminar tareas.

## Requisitos

- Node.js 20.19+ o 22.12+
- Un proyecto Supabase para usar autenticación y sincronización en la nube (opcional para modo local)

## Ejecutar en modo local

```bash
npm install
npm run dev
```

Sin variables de Supabase, las tareas se guardan únicamente en el navegador actual mediante `localStorage`.

## Conectar Supabase

1. En el SQL Editor del proyecto Supabase, ejecuta [`supabase/schema.sql`](supabase/schema.sql).
2. Copia `.env.example` como `.env.local` y completa la URL del proyecto y su clave pública `anon`/`publishable`.
3. En Supabase Auth, habilita el proveedor de correo electrónico.
4. Reinicia el servidor de desarrollo.

La app ofrece registro e inicio de sesión con correo y contraseña. Cada fila guarda `responsible_id` y `created_by` con el UUID del usuario autenticado. Las políticas RLS limitan las filas al usuario responsable o creador. La versión inicial asigna las tareas al usuario que inició sesión.

No coloques claves `service_role` en variables `VITE_*` ni en el navegador.

## Compilar

```bash
npm run build
```

## Git y GitHub

```bash
git init
git add .
git commit -m "feat: crear gestor de tareas"
git branch -M main
git remote add origin https://github.com/USUARIO/REPOSITORIO.git
git push -u origin main
```

Reemplaza `USUARIO/REPOSITORIO` por el repositorio que crees en GitHub. El archivo `.env.local` está excluido por Git.
