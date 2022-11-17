package taskmanager.backend.dtos

import taskmanager.backend.models.User

data class AuthDto(
    val token: String,
    val user: User? = null
)
