package taskmanager.backend.services

interface AuthService {
    fun generateToken(id: String, email: String): String
}