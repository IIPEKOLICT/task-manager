package taskmanager.backend.di

import io.ktor.server.application.*
import org.koin.core.module.Module
import org.koin.dsl.module
import taskmanager.backend.shared.DatabaseManager
import taskmanager.backend.services.impl.AuthServiceImpl
import taskmanager.backend.services.impl.FileServiceImpl
import taskmanager.backend.services.impl.S3ServiceImpl
import taskmanager.backend.services.impl.UserServiceImpl
import taskmanager.backend.services.AuthService
import taskmanager.backend.services.FileService
import taskmanager.backend.services.S3Service
import taskmanager.backend.services.UserService
import taskmanager.backend.shared.Configuration

object AppModule {

    fun get(environment: ApplicationEnvironment): Module {
        return module {
            single { Configuration(environment.config) }

            single {
                DatabaseManager(get()).init().getDatabase()
            }

            single<UserService> { UserServiceImpl(get()) }
            single<AuthService> { AuthServiceImpl(get()) }

            single<S3Service> { S3ServiceImpl(get()) }
            single<FileService> { FileServiceImpl() }
        }
    }
}