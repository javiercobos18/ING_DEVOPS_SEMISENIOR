# Prueba Técnica - Ingeniero DevOps Semi-Senior
 
**Duración estimada**: 3-4 horas  
**Modalidad**: Práctica en casa con presentación posterior  
**Objetivo**: Evaluar capacidades técnicas en CI/CD, Kubernetes, seguridad y automatización
 
---
 
## Contexto
 
Eres parte de la célula DevOps de una empresa financiera que está modernizando su plataforma CI/CD. El equipo trabaja con:
- **CI/CD**: Jenkins, GitHub Actions
- **Contenedores**: Docker, Kubernetes (AKS)
- **Calidad**: SonarQube, Fortify
- **Gestión de artefactos**: Artifactory, ACR (Azure Container Registry)
- **IaC**: Terraform, Helm
- **Cloud**: Azure
 
---
 
## Parte 1: Pipeline CI/CD con GitHub Actions (40 puntos)
 
### Escenario
Debes crear un pipeline de CI/CD para una aplicación Python (FastAPI) que:
- Se despliega en Azure Kubernetes Service (AKS)
- Requiere análisis de calidad y seguridad
- Sigue el modelo "build once, deploy many"
 
### Tareas
 
**A) Workflow de GitHub Actions** (25 puntos)
 
Crea un archivo `.github/workflows/ci-cd.yml` que incluya:
 
1. **Etapa de Build**:
   - Checkout del código
   - Build de imagen Docker
   - Tag semántico (ej: `v1.2.3-commit-sha`)
   - Push a Azure Container Registry
 
2. **Etapa de Quality Gates**:
   - Análisis con SonarQube (simular con script simple)
   - Escaneo de vulnerabilidades con Trivy o similar
   - Validación de cobertura mínima (80%)
 
3. **Etapa de Deploy**:
   - Deploy a ambiente de staging automáticamente
   - Deploy a producción solo si:
     - Es una etiqueta (tag) de release
     - Tiene aprobación manual
   - Utilizar Helm para el despliegue
 
**B) Dockerfile multi-stage** (10 puntos)
 
Crea un `Dockerfile` optimizado para la aplicación Python:
- Implementa build multi-stage
- Imagen final ligera (Alpine o distroless)
- No root user
- Health checks incluidos
- Tamaño final < 150MB
 
**C) Preguntas de diseño** (5 puntos)
 
Responde brevemente:
1. ¿Cómo implementarías el rollback automático si el deployment falla?
2. ¿Qué estrategia de caché usarías para acelerar el build de la imagen Docker?
3. ¿Cómo asegurarías los secrets en el pipeline?
 
---
 
## Parte 2: Manifiesto de Kubernetes Robusto (30 puntos)
 
### Escenario
El equipo ha tenido problemas con despliegues que fallan silenciosamente y aplicaciones que no se recuperan bien de fallos de nodos.
 
### Tareas
 
**A) Chart de Helm** (20 puntos)
 
Crea un chart de Helm (`deployment.yaml` y `values.yaml`) para la aplicación que incluya:
 
1. **Resiliencia**:
   - Probes: liveness, readiness, startup
   - Resources: requests y limits definidos
   - PodDisruptionBudget con mínimo 1 pod disponible
   - Múltiples réplicas (mínimo 2)
 
2. **Estrategia de despliegue**:
   - Rolling update con maxUnavailable y maxSurge configurados
   - Annotations para prometheus metrics
 
3. **Afinidad y tolerancias**:
   - Node affinity para preferir nodos con label `workload=api`
   - Pod anti-affinity para distribuir réplicas
   - Tolerations si existen nodos con taints
 
4. **Seguridad**:
   - SecurityContext (non-root, readOnlyRootFilesystem)
   - NetworkPolicy básica (opcional, bonus)
 
**B) Preguntas de troubleshooting** (10 puntos)
 
Responde:
1. Un pod está en estado `CrashLoopBackOff`. ¿Qué comandos usarías para diagnosticar?
2. El deployment se completó pero los usuarios reportan errores 503. ¿Qué revisarías?
3. ¿Cómo implementarías una estrategia blue-green en AKS?
 
---
 
## Parte 3: Automatización y Scripting (20 puntos)
 
### Escenario
El equipo necesita automatizar tareas repetitivas de operaciones.
 
### Tareas
 
**A) Script de backup automatizado** (10 puntos)
 
Crea un script en Bash o Python que:
- Realice backup de secrets de Kubernetes de un namespace específico
- Genere archivo `.tar.gz` con timestamp
- Suba el backup a Azure Blob Storage
- Limpie backups antiguos (> 7 días)
- Envíe notificación (simulada) al equipo vía webhook
 
**B) Script de health check** (10 puntos)
 
Crea un script que:
- Verifique el estado de los pipelines de Jenkins vía API REST
- Liste los últimos 5 builds fallidos
- Genere un reporte Markdown con:
  - Total de pipelines
  - % de éxito/fallo
  - Top 3 pipelines más inestables
- Bonus: Gráfico simple en ASCII o envío a Slack
 
---
 
## Parte 4: Seguridad y Compliance (10 puntos)
 
### Preguntas de caso práctico
 
1. **SAML/SSO (3 puntos)**:  
   El equipo necesita implementar autenticación SAML en SonarQube. Describe los pasos principales y qué información necesitarías del IdP.
 
2. **Secrets Management (4 puntos)**:  
   ¿Cómo gestionarías secrets sensibles (API keys, passwords) en:
   - Pipelines de GitHub Actions
   - Manifiestos de Kubernetes
   - Scripts de automatización
   Menciona herramientas y best practices.
 
3. **Fortify/SAST (3 puntos)**:  
   Un escaneo de Fortify reporta una vulnerabilidad crítica de SQL Injection. ¿Qué pasos seguirías desde DevOps para gestionar este hallazgo hasta su resolución?
 
---
 
## Entregables
 
1. **Código**:
   - Ffeature en este repo con todos los archivos (workflows, Dockerfile, Helm charts, scripts)
   - README.md explicando cómo probar cada componente
 
2. **Documentación**:
   - Respuestas a todas las preguntas
   - Decisiones de diseño y trade-offs considerados
   - Diagrama simple del flujo CI/CD propuesto (puede ser ASCII art o draw.io)
   - VoBo
       **Autorizo a PORVENIR S.A., según Ley 1581/2012 y Decreto 1377/2013, a tratar mis datos personales para el proceso de selección, validarlos, conservarlos o eliminarlos según el resultado.**

 
3. **Presentación** (15 minutos):
   - Demo del pipeline funcionando (puede ser simulado localmente)
   - Explicación de decisiones técnicas
   - Discusión de mejoras futuras
   - 
 
---
 
## Criterios de Evaluación
 
| Área | Peso | Criterios |
|------|------|-----------|
| **Funcionalidad** | 40% | ¿El código funciona? ¿Cumple los requisitos? |
| **Mejores prácticas** | 30% | Seguridad, optimización, clean code |
| **Conocimiento técnico** | 20% | Profundidad en respuestas, troubleshooting |
| **Documentación** | 10% | Claridad, completitud, diagramas |
 
---
 
## Bonus (No obligatorio, +10 puntos)
 
- Implementar GitOps con ArgoCD (configuración básica)
- Agregar etapa de pruebas de performance (K6, JMeter)
- Configurar observabilidad (Prometheus/Grafana dashboards)
- Implementar policy-as-code con OPA o Kyverno
 
---
 
## Recursos Permitidos
 
✅ Documentación oficial (Kubernetes, Docker, Azure, GitHub Actions)  
✅ Stack Overflow y recursos públicos  
✅ Herramientas locales (Minikube, Kind, Docker Desktop)  
 
❌ No copiar código completo de repos externos (sí inspección y adaptación)  
❌ No usar ChatGPT/Copilot para generar código completo (sí como ayuda en sintaxis/docs)
 
---
 
## Preguntas
 
Si tienes dudas sobre el alcance o necesitas clarificaciones, contáctanos a: [por14321@porvenir.com.co]
 
**¡Éxito en tu prueba!** 🚀

# Prueba Técnica - Ingeniero DevOps Semi-Senior

## Contexto
Breve descripción del reto técnico y objetivos.

---

## Solución

Pipeline CI/CD
Archivo: .github/workflows/ci-cd.yml

Lo que armé en el pipeline fue lo siguiente:

Tests  
Incluí linting con flake8/ruff, pruebas unitarias con pytest y un reporte de cobertura. El pipeline está configurado para fallar si la cobertura baja de 80%, porque considero que ese es un mínimo aceptable para mantener calidad.

Quality Gate  
Simulé la integración con SonarQube usando un script (scripts/simulate_sonar.sh). En un entorno real se reemplazaría por la acción oficial o un servidor SonarQube.
También agregué un escaneo de vulnerabilidades con Trivy (scripts/trivy_scan.sh), que corta el pipeline si encuentra vulnerabilidades críticas.

Build & Push  
La imagen Docker se construye con un build multi‑stage usando BuildKit.
El tagging es semántico: v1.runNumber-sha (ejemplo: v1.42-3f2a1b2).
Finalmente, la imagen se publica en Azure Container Registry (ACR), autenticando con secrets de GitHub.

Deploy Staging  
El despliegue a staging es automático, usando Helm (helm upgrade --install). Después de desplegar, corro un smoke test (curl /health) para validar que el servicio esté vivo.

Deploy Producción  
Solo se ejecuta en tags de release y requiere aprobación manual. Incluye verificación de rollout y rollback automático si algo falla.

Dockerfile (multi‑stage para FastAPI)
Usé un multi‑stage build: la etapa builder instala dependencias y genera artefactos, y la etapa runtime copia solo lo necesario.

La base es python:3.11-slim, que me da un buen balance entre tamaño y compatibilidad.

Creé un usuario no‑root (appuser) y ajusté permisos para evitar correr como root.

Definí un healthcheck:

dockerfile

HEALTHCHECK CMD curl -f http://localhost:8000/health || exit 1
Optimicé el tamaño usando pip --no-cache-dir, limpiando paquetes de build y copiando solo lo esencial.

El objetivo es que la imagen final quede por debajo de 150MB. Si se excede, documenté alternativas como usar distroless o wheels precompilados.

Helm (chart y manifiestos)
Archivos clave: chart/templates/deployment.yaml, chart/values.yaml, chart/templates/service.yaml, chart/templates/pdb.yaml

Lo que configuré en el chart:

Probes de liveness, readiness y startup.

Requests y limits de CPU/memoria.

PodDisruptionBudget con minAvailable: 1.

Réplicas por defecto: 2.

Estrategia de despliegue: RollingUpdate con maxUnavailable=1 y maxSurge=1.

Node affinity (workload=api) y pod anti‑affinity para distribuir réplicas.

Tolerations para nodos con taints.

SecurityContext: non‑root, filesystem read‑only, sin escalamiento de privilegios.

Anotaciones para Prometheus (prometheus.io/scrape: "true").

NetworkPolicy básica opcional para restringir tráfico.

Scripts incluidos
backup.sh  
Exporta secrets de un namespace, los empaqueta en backup-YYYYMMDD-HHMMSS.tar.gz, los sube a Azure Blob Storage y limpia backups mayores a 7 días. Simula notificación a un webhook.

healthcheck.py  
Consulta el endpoint /health, genera un report.md con estado y tiempos de respuesta. Puede consultar Jenkins si se configuran credenciales.

simulate_sonar.sh  
Simula un análisis SonarQube (útil para demo local sin servidor).

trivy_scan.sh  
Wrapper para ejecutar Trivy contra la imagen; falla si hay vulnerabilidades críticas.

Seguridad
Decidí usar SonarQube como quality gate principal, porque es la herramienta que más he usado en proyectos financieros y de consultoría. Me da un dashboard centralizado con métricas de calidad y cobertura, y facilita la trazabilidad en entornos críticos.

Trivy lo mantengo como complemento para escaneo de imágenes, y Bandit lo considero opcional si se requiere análisis específico de Python.

En cuanto a secrets:

En GitHub Actions los gestiono con GitHub Secrets.

En Kubernetes prefiero Sealed Secrets o Secrets Store CSI con Azure Key Vault.

En scripts, uso variables de entorno o integración directa con Key Vault.

La imagen runtime corre como non‑root, con filesystem read‑only y sin privilegios extra.

# Preguntas de diseño

Rollback automático  
Configuro probes estrictos y progressDeadlineSeconds. Si el rollout falla, Kubernetes lo marca y puedo ejecutar kubectl rollout undo. También mantengo maxUnavailable en Helm para asegurar al menos una réplica estable.

Estrategia de caché en Docker  
Ordeno las capas: primero requirements.txt, luego dependencias, y al final el código. Así evito reconstruir todo en cada cambio.

Secrets en pipeline

GitHub Actions: secrets en Settings.

Kubernetes: Secrets cifrados, Sealed Secrets o External Secrets.

Scripts: variables de entorno o integración con Azure Key Vault.

# Troubleshooting

CrashLoopBackOff  
Uso kubectl logs <pod>, kubectl describe pod <pod> y reviso eventos. También valido probes y recursos asignados.

Errores 503 tras deploy  
Reviso el Service e Ingress, confirmo que los pods pasaron readiness y valido conectividad interna con kubectl exec curl.

Blue‑green en AKS  
Despliego una versión paralela (green) en un namespace o con labels distintos, valido con smoke tests y luego redirijo tráfico con el Ingress Controller. Mantengo blue como fallback.

# Seguridad y compliance

SAML/SSO en SonarQube  
Necesito metadata del IdP (entityID, certificados, endpoints). Configuro el plugin SAML en SonarQube, registro la app en el IdP y pruebo login con usuarios de prueba.

Gestión de secrets

GitHub Actions: secrets en Settings.

Kubernetes: Secrets cifrados y montados como env/volumen.

Scripts: variables de entorno o integración con Azure Key Vault.

Fortify/SAST SQL Injection  
Marco el hallazgo como crítico, notifico al equipo de desarrollo, abro ticket en Jira y acompaño la corrección con pruebas unitarias y validación en pipeline.

# Decisiones de diseño y trade‑offs

SonarQube vs Bandit/Trivy: preferí SonarQube porque refleja mi experiencia real y centraliza métricas de calidad y seguridad.

Build once, deploy many: un único build de imagen garantiza reproducibilidad y trazabilidad.

Seguridad pragmática: usuario non‑root, filesystem protegido y manejo de secrets con GitHub/Kubernetes.

Resiliencia: probes estrictos y rolling updates para despliegues seguros.
