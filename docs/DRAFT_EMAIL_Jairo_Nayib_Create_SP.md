Asunto: Solicitud: creación de Service Principal y asignación de permisos para proyecto “HermesAgentic” (Universidad del Rosario)

Ing. Jairo Nayib,

Buen día. Soy Fredy Alejandro Sarmiento (equipo de Data/AI). Le escribo para solicitar su apoyo puntual con permisos en la suscripción de Azure de la Universidad del Rosario para poner en marcha Hermes Enterprise — una versión Enterprise de Hermes Agent orientada a Azure Foundry que usaremos para integrar LLMs y automatización en nuestros flujos de investigación y operación.

Resumen ejecutivo
- Repositorio y avances: código base listo (rama feature/runtime-core, tag v2.0-bootstrap) y primer runtime funcional. Estamos listos para avanzar a la v2.1, cuyo objetivo es construir un Kernel central y motores (Provider Registry, Router Engine, Memory, FinOps, integración con VS Code, etc.).
- Objetivo inmediato: habilitar despliegue y operación automatizada del entorno Hermes en un resource group dedicado, y crear un Service Principal (SP) para que los pipelines y servicios (CI/CD, integraciones) accedan de forma segura al entorno y a los modelos LLM de Azure Foundry.
- Beneficio para la Universidad: control y trazabilidad del uso de LLMs (FinOps), separación de identidades (no usar cuentas personales en scripts), auditoría y capacidad reproducible para investigación y despliegue.

Estado actual (verificado por mi sesión)
- Suscripción activa: 01bfad48-c092-4712-bc72-f141eb01a8d4 (Sub-Tecnologia-Datamining)
- Resource group creado que respeta la política de nombres: RG-HermesAgentic (ubicación: eastus)
- Roles actuales de analiticaur@urosario.edu.co en la suscripción: Key Vault Secrets Officer; Cost Management Contributor; Cost Management Reader
- Intento de crear Service Principal: falló con "Insufficient privileges to complete the operation" (la cuenta no puede registrar apps en Azure AD)

Por qué solicitamos su intervención
- La creación programática de un Service Principal requiere registrar una aplicación en Azure AD o que un administrador con privilegios (Owner / Global Admin) cree la app/SP. Sin la intervención de un administrador no podemos generar el SP ni otorgarle permisos al recurso.
- También es conveniente que un administrador confirme la política de registro de aplicaciones o cree el app registration en su nombre para mantener control centralizado.

Acción solicitada (comandos listos para ejecutar)
Preferible ejecutar desde Cloud Shell (o PowerShell con una cuenta con privilegios Owner / Global Admin). Copiar y pegar los comandos siguientes:

1) (Opcional) permitir que los usuarios registren aplicaciones en AAD (si decide hacerlo desde portal):
   Azure Active Directory → User settings → App registrations → Users can register applications = Yes

2) Crear Service Principal y asignarle Contributor sobre RG-HermesAgentic:

   az account set --subscription 01bfad48-c092-4712-bc72-f141eb01a8d4

   az ad sp create-for-rbac \
     --name "http://sp-hermesagentic" \
     --role Contributor \
     --scopes /subscriptions/01bfad48-c092-4712-bc72-f141eb01a8d4/resourceGroups/RG-HermesAgentic \
     -o json

   - El comando devuelve JSON con appId (clientId), password (clientSecret) y tenant. Favor de guardar el secret en Azure Key Vault y no compartirlo en texto plano.

   Si la creación por create-for-rbac falla por políticas de registro de apps, alternativamente (Admin):
   a) az ad app create --display-name "sp-hermesagentic-app" --identifier-uris "http://sp-hermesagentic" -o json
   b) az ad sp create --id <appId>
   c) az role assignment create --assignee <appId> --role Contributor --scope /subscriptions/01bfad48-c092-4712-bc72-f141eb01a8d4/resourceGroups/RG-HermesAgentic

3) Asignar permiso Contributor a fredya.sarmiento@urosario.edu.co sobre RG-HermesAgentic (recomendado para desarrollo y ejecución):

   az role assignment create \
     --assignee fredya.sarmiento@urosario.edu.co \
     --role "Contributor" \
     --scope /subscriptions/01bfad48-c092-4712-bc72-f141eb01a8d4/resourceGroups/RG-HermesAgentic

4) (Opcional y recomendado) Crear Key Vault y almacenar el secreto del SP:

   az keyvault create -n kv-hermesagentic -g RG-HermesAgentic -l eastus
   az keyvault secret set --vault-name kv-hermesagentic --name "sp-hermesagentic-secret" --value "<clientSecret>"

   - Otorgar acceso al SP si necesita leer secretos:
     az role assignment create --assignee <appId> --role "Key Vault Secrets User" --scope /subscriptions/01bfad48-c092-4712-bc72-f141eb01a8d4/resourceGroups/RG-HermesAgentic/providers/Microsoft.KeyVault/vaults/kv-hermesagentic

Buenas prácticas y seguridad
- Guardar clientSecret en Key Vault y habilitar rotación.
- No compartir secret por correo o chat. Usar Key Vault o CI secret store.
- Limitar el alcance del SP al RG (no dar permisos a toda la subscripción salvo que sea necesario).
- Revisar y auditar las asignaciones periódicamente.

Próximos pasos que puedo realizar si lo autoriza
- Ejecutar los comandos aquí (si se habilitan registros de app o si el Admin me autoriza temporalmente). Actualmente la creación del SP falló por permisos.
- Preparar un script ejecutable para Cloud Shell y dejarlo listo en un gist o en el repositorio para que lo ejecute usted o el administrador.

Agradezco mucho su apoyo. Si lo prefiere, puedo pasar por su oficina o coordinamos una sesión de 10 minutos para ejecutar los comandos con su cuenta.

Saludos cordiales,

Fredy Alejandro Sarmiento Torres
Equipo Data/AI — Universidad del Rosario

---
Resumen técnico (anexo rápido):
- Suscripción: 01bfad48-c092-4712-bc72-f141eb01a8d4
- Resource group ya creado: RG-HermesAgentic (eastus)
- Recurso solicitado: Service Principal para "sp-hermesagentic" con role Contributor sobre RG-HermesAgentic
- Usuario a elevar (dev): fredya.sarmiento@urosario.edu.co (Contributor sobre RG)


