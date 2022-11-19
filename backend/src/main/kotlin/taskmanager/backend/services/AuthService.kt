package taskmanager.backend.services

import org.bson.types.ObjectId

interface AuthService {
    fun generateToken(id: ObjectId, email: String): String
}