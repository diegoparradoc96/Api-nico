# ==========================================
# ETAPA 1: Compilación y Preparación (Builder)
# ==========================================
FROM node:22-alpine AS builder

# Instalar pnpm de forma nativa e independiente
RUN npm install -g pnpm

WORKDIR /app

# Copiar archivos de configuración de dependencias y la carpeta prisma
COPY package*.json pnpm-workspace.yaml* pnpm-lock.yaml* ./
COPY prisma ./prisma/

# Instalar TODAS las dependencias (incluyendo devDependencies para compilar TS)
RUN pnpm install --frozen-lockfile

# Generar el cliente de Prisma para que esté disponible durante la compilación
RUN pnpm prisma generate

# Copiar el resto del código fuente del proyecto
COPY . .

# Compilar TypeScript a JavaScript puro (crea la carpeta dist/)
RUN pnpm run build

# Eliminar dependencias de desarrollo y dejar solo las necesarias para producción
RUN pnpm prune --prod

# ==========================================
# ETAPA 2: Entorno de Ejecución Real (Runner)
# ==========================================
FROM node:22-alpine AS runner

WORKDIR /app

# Configurar entorno de producción
ENV NODE_ENV=production
ENV PORT=3000

# Copiar solo lo estrictamente necesario desde la etapa de compilación
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

# Informar el puerto que Express dejará abierto
EXPOSE 3000

# Comando de arranque optimizado para producción
CMD ["node", "dist/server.js"]