package taskmanager.backend.di

import io.ktor.server.application.*
import org.koin.core.module.Module
import org.koin.dsl.module
import taskmanager.backend.services.*
import taskmanager.backend.services.impl.*
import taskmanager.backend.shared.DatabaseManager
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
            single<ProjectService> { ProjectServiceImpl(get()) }
            single<TagService> { TagServiceImpl(get()) }

            single<S3Service> { S3ServiceImpl(get()) }
            single<FileService> { FileServiceImpl() }
        }
    }
}