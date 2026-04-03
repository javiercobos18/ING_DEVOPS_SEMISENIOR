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

--------------------------------------------------------------------------------------------------------------------

## Solución


## 1. Punto de partida

El repositorio que se entregó estaba incompleto y no era ejecutable, esto debido a que mi ambiente inicial no me permitía 
ejecutar las pruebas y tuve que optimizar mis recursos para lograrlo, allí evidencié lo siguiente:

- No existía `src/` funcional
- Faltaba `requirements.txt`
- Helm estaba mal estructurado
- El pipeline tenía inconsistencias

En este estado, el proyecto no corría localmente.

## 2. Validación inicial

Intenté construir la imagen con Docker:

docker build -t fastapi-app 

Resultado: falló porque no existía la carpeta src/ ni el archivo requirements.txt

## 3. Solución base (app mínima)

Se creó una aplicación mínima con FastAPI y dependencias en requirements.txt.
Esto permitió tener un punto de partida funcional para validar Docker y healthcheck.

## 4. Validación Docker y Healthcheck

Una vez creada la aplicación mínima, el siguiente paso fue validar 
que pudiera construirse y ejecutarse dentro de un contenedor Docker. 
 
Primero intenté el build:

docker build -t fastapi-app .

La construcción fue exitosa. Luego ejecuté el contenedor:

docker run -p 8000:80 fastapi-app

Al probar con curl localhost:8000, la aplicación respondió correctamente, 
lo que confirmó que el servicio básico estaba vivo.

Sin embargo, al correr el script de healthcheck, obtuve un error 404.
El problema era que el script esperaba un endpoint /health, mientras 
que la aplicación solo exponía /.

La solución fue agregar un endpoint específico de salud.

Con esto, tanto la prueba manual (curl localhost:8000/health) 
como el script (python3 scripts/healthcheck.py) pasaron satisfactoriamente.

## 5. Helm

El siguiente reto fue la configuración de Helm. Al ejecutar:


helm template test ./helm

aparecieron errores, faltaba Chart.yaml y el archivo deployment.yaml 
estaba en la raíz en lugar de templates/.

La solución fue crear la carpeta adecuada y mover los manifiesto, 
después de este ajuste, el comando helm template renderizó correctamente,
lo que validó que la estructura del chart era funcional.

## 6. Pipeline CI/CD

Para garantizar calidad y automatización, diseñé un pipeline en 
.github/workflows/ci-cd.yml con varias etapas:

- Tests: 
		 linting con flake8/ruff, pruebas unitarias con pytest y 
         reporte de cobertura. El pipeline falla si la cobertura 
		 baja de 80%, asegurando un mínimo aceptable de calidad. 
		 
- Quality Gate: 
		 integración simulada con SonarQube y escaneo de vulnerabilidades 
		 con Trivy. Esto permite cortar el pipeline si se detectan 
		 problemas críticos. 
		 
- Build & Push: 
		 construcción de la imagen Docker con build multi‑stage, 
		 tagging semántico (v1.runNumber-sha) y publicación en Azure 
		 Container Registry.  
		 
- Deploy Staging: 
		 despliegue automático con Helm y validación mediante 
         un smoke test al endpoint /health. 
		 
- Deploy Producción: 
		 solo en tags de release, requiere aprobación manual y cuenta 
		 con rollback automático en caso de fallo.



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

Blue/green en AKS  
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

Seguridad pragmática: usuario nonroot, filesystem protegido y manejo de secrets con GitHub/Kubernetes.

Resiliencia: probes estrictos y rolling updates para despliegues seguros.


