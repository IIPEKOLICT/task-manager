package taskmanager.backend.di

import io.ktor.server.application.*
import org.koin.core.module.Module
import org.koin.dsl.module
import taskmanager.backend.DatabaseManager
import taskmanager.backend.services.AuthService
import taskmanager.backend.services.UserService
import taskmanager.backend.services.interfaces.IAuthService
import taskmanager.backend.services.interfaces.IUserService
import taskmanager.backend.shared.Configuration

object AppModule {

    fun get(environment: ApplicationEnvironment): Module {
        return module {
            single { Configuration(environment.config) }

            single {
                DatabaseManager(get()).init().getDatabase()
            }

            single<IUserService> { UserService(get()) }
            single<IAuthService> { AuthService(get()) }
        }
    }
}