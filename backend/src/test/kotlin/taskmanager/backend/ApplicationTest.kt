package taskmanager.backend

import io.ktor.http.*
import io.ktor.client.request.*
import io.ktor.server.testing.*
import junit.framework.TestCase.*
import org.junit.Test

class ApplicationTest {
    @Test
    fun testRoot() = testApplication {
        application {}

        client.get("/test").apply {
            assertEquals(HttpStatusCode.OK, status)
        }
    }
}