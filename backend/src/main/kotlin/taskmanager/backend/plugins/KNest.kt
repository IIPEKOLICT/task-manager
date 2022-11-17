package taskmanager.backend.plugins

import com.github.iipekolict.knest.KNest
import io.ktor.http.*
import io.ktor.serialization.gson.*
import io.ktor.server.application.*
import org.bson.types.ObjectId
import taskmanager.backend.controllers.AuthController
import taskmanager.backend.controllers.MainController
import taskmanager.backend.controllers.UserController
import taskmanager.backend.injectors.JwtUserInjector
import taskmanager.backend.injectors.LocalUserInjector
import taskmanager.backend.serialization.DateDeserializer
import taskmanager.backend.serialization.DateSerializer
import taskmanager.backend.serialization.ObjectIdDeserializer
import taskmanager.backend.serialization.ObjectIdSerializer
import java.util.Date

fun Application.configureKNest() {
    install(KNest) {
        framework {
            setControllers(
                MainController(),
                UserController(),
                AuthController()
            )

            addPropertyInjectors(JwtUserInjector::class, LocalUserInjector::class)
        }

        exceptionHandling {
            setContainers()
        }

        cors {
            allowMethod(HttpMethod.Options)
            allowMethod(HttpMethod.Patch)
            allowMethod(HttpMethod.Put)
            allowMethod(HttpMethod.Delete)
            allowHeader(HttpHeaders.Authorization)
            anyHost()
        }

        contentNegotiation {
            gson {
                registerTypeAdapter(ObjectId::class.java, ObjectIdSerializer())
                registerTypeAdapter(ObjectId::class.java, ObjectIdDeserializer())
                registerTypeAdapter(Date::class.java, DateSerializer())
                registerTypeAdapter(Date::class.java, DateDeserializer())
                setPrettyPrinting()
            }
        }

        swagger {
            swagger {
                forwardRoot = true
            }

            info {
                title = "Task manager"
                version = "latest"
                description = "Task manager API documentation"

                contact {
                    name = "API Support"
                    url = "https://github.com/IIPEKOLICT"
                    email = "iipekolict@gmail.com"
                }

                license {
                    name = "MIT"
                    url = "https://raw.githubusercontent.com/IIPEKOLICT/task-manager/main/LICENSE"
                }
            }

            server {
                url = "http://localhost:5000"
                description = "Development server"
            }

            System.getenv("BACKEND_URL")?.let {
                server {
                    url = it
                    description = "Production server"
                }
            }
        }
    }
}