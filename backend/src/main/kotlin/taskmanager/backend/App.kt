package taskmanager.backend

import io.ktor.server.netty.EngineMain
import io.ktor.server.application.*
import taskmanager.backend.plugins.configureAuthorization
import taskmanager.backend.plugins.configureKNest
import taskmanager.backend.plugins.configureKoin

fun main(args: Array<String>): Unit = EngineMain.main(args)

fun Application.launch() {
    configureKoin()
    configureKNest()
    configureAuthorization()
}