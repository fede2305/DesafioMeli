# DesafioMeli

Especificación del Desafío
Un equipo de MeLi nos pide ayuda en la creación de la infraestructura de Networking (en AWS) para su proyecto. Debemos crear utilizando templates de Terraform:
Una vpc con las subnets que creas necesarias.
Recursos necesarios para su correcto ruteo y securización.
 cumpliendo los siguientes requisitos:
Salida a internet solo por Nat Gateway.
Restricción de entrada solo en puertos específicos para rangos específicos y Security Groups específicos.
Restringir algunas ips internas en el tráfico saliente.
Creado y ruteo de conexión contra otra vpc.
Investigando un poco más, notamos que otros equipos poseen una necesidad similar por lo que sería conveniente que la solución sea fácilmente extensible y mantenible para que pueda ajustarse a los distintos pedidos.
Esta solución centralizada nos permitirá automatizar y aplicar templates de Terraform.
Deseables:

Template en formato Terraform


Tener algún dibujo, diagrama u otros sobre cómo es el diseño, funcionamiento, escalabilidad y monitoreo de la solución que automatiza el aplicado de dichos templates..
