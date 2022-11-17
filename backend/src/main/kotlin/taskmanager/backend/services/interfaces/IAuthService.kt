package taskmanager.backend.services.interfaces

interface IAuthService {
    fun generateToken(id: String, email: String): String
}