# Minimal Dockerfile for placeholder-siden i public/.
# Bytt ut hele denne fila når prosjektet får en faktisk stack
# (Node, Python, osv). Coolify bygger fra hvilken Dockerfile
# som helst i rota, så dette er bare et startpunkt.

FROM nginx:alpine
COPY public/ /usr/share/nginx/html/
EXPOSE 80
