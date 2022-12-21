package taskmanager.backend

import io.ktor.client.call.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.http.*
import io.ktor.client.request.*
import io.ktor.serialization.gson.*
import io.ktor.server.testing.*
import junit.framework.TestCase.*
import org.junit.Test
import taskmanager.backend.dtos.HealthCheckDto

class ApplicationTest {
    @Test
    fun `test healthCheck endpoint`() = testApplication {
        application {}

        val httpClient = createClient {
            install(ContentNegotiation) {
                gson()
            }
        }

        httpClient.get("/test").apply {
            val body: HealthCheckDto = body()

            assertEquals(HttpStatusCode.OK, status)
            assertEquals("ok", body.status)
        }
    }
}