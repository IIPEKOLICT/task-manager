package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.Get
import io.ktor.server.application.*
import io.ktor.server.response.*

@Controller
class MainController {
    @Get("test")
    suspend fun healthCheck(): Map<String, String> {
        return mapOf("status" to "ok")
    }
}