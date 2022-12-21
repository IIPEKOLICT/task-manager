package taskmanager.backend.di

import io.ktor.server.application.*
import org.koin.core.module.Module
import org.koin.dsl.module
import taskmanager.backend.controllers.*
import taskmanager.backend.mappers.*
import taskmanager.backend.plugins.exceptions.ExceptionContainer
import taskmanager.backend.services.*
import taskmanager.backend.services.impl.*
import taskmanager.backend.shared.Configuration

object TestModule {

    fun get(environment: ApplicationEnvironment): Module {
        val configuration = Configuration(environment.config)

        return module {
            single { configuration }

            single<AuthService> { AuthServiceImpl(get()) }

            single<S3Service> { S3ServiceImpl(get()) }
            single<FileService> { FileServiceImpl() }

            single { ExceptionContainer() }

            single { GanttMapper() }

            single { MainController() }
        }
    }
}