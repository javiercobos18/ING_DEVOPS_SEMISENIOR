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
