package taskmanager.backend.shared

import io.ktor.server.config.*
import io.ktor.server.engine.*
import org.koin.core.module.Module
import taskmanager.backend.di.TestModule

object Utils {

    private val environment = ApplicationEngineEnvironmentBuilder()
        .build {
            config = ApplicationConfig(null)
        }

    val koinTestModule: Module = TestModule.get(environment)
}