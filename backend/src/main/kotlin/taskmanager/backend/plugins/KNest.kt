package taskmanager.backend.plugins

import com.github.iipekolict.knest.KNest
import io.ktor.http.*
import io.ktor.serialization.gson.*
import io.ktor.server.application.*
import org.bson.types.ObjectId
import org.koin.ktor.ext.inject
import taskmanager.backend.controllers.*
import taskmanager.backend.plugins.exceptions.ExceptionContainer
import taskmanager.backend.plugins.injectors.JwtUserInjector
import taskmanager.backend.plugins.injectors.LocalUserInjector
import taskmanager.backend.plugins.middlewares.MiddlewareContainer
import taskmanager.backend.plugins.serialization.DateDeserializer
import taskmanager.backend.plugins.serialization.DateSerializer
import taskmanager.backend.plugins.serialization.ObjectIdDeserializer
import taskmanager.backend.plugins.serialization.ObjectIdSerializer
import java.util.Date

fun Application.configureKNest() {
    val mainController by inject<MainController>()
    val authController by inject<AuthController>()
    val userController by inject<UserController>()
    val projectController by inject<ProjectController>()
    val tagController by inject<TagController>()
    val taskController by inject<TaskController>()
    val workController by inject<WorkController>()
    val commentController by inject<CommentController>()
    val noteController by inject<NoteController>()
    val attachmentController by inject<AttachmentController>()

    val middlewareContainer by inject<MiddlewareContainer>()
    val exceptionContainer by inject<ExceptionContainer>()

    install(KNest) {
        framework {
            setControllers(
                mainController,
                userController,
                authController,
                projectController,
                tagController,
                taskController,
                workController,
                commentController,
                noteController,
                attachmentController
            )

            addPropertyInjectors(JwtUserInjector::class, LocalUserInjector::class)
        }

        exceptionHandling {
            setContainers(exceptionContainer)
        }

        middleware {
            setContainers(middlewareContainer)
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