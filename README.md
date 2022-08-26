| Feed/Home | Lista de lugares | Detalle de un prócer |
| --- | --- | --- |
| <img src="https://user-images.githubusercontent.com/26754335/186966224-756103bd-eb65-4f45-b017-7f14059ae69b.png" width="250"> |   <img src="https://user-images.githubusercontent.com/26754335/186966391-a4493cef-2547-459c-a316-f3adde4892a5.png" width="250"> | <img src="https://user-images.githubusercontent.com/26754335/186966511-cadf9991-827c-45dc-9bce-881254dc0d13.png" width="250"> |

*Este repositorio contiene el código fuente de la app Payan en su version en iOS.*


### Stack 

* SwiftUI para el UI de toda la app. Cabe aclarar que para la navegación se utiliza UIKit (resulta que la navegación con SwiftUI es *such a pain in the ass*).
* Firebase, más especificamente, Analitycs.
* Swift Package Manager como gestor de paquetes.
* Para conectarse con los servicios REST no se utilizaron paquetes de terceros, únicamente URLSession.

### Todo's

- [ ] Mirgrar la arquitectura de los módulos a redux.
- [ ] Soportar el idioma Inglés.
- [ ] Implementar `async await`.
- [ ] Permitir a los usuarios enviar comentarios a manera de feedback.
- [ ] Crear un nuevo módulo de elementos característicos de la ciudad.

¡Un saludo!
