package taskmanager.backend.plugins

import io.ktor.server.application.*
import org.koin.ktor.plugin.Koin
import org.koin.logger.slf4jLogger
import taskmanager.backend.di.AppModule

fun Application.configureKoin() {
    install(Koin) {
        slf4jLogger()
        modules(AppModule.get(environment))
    }
}