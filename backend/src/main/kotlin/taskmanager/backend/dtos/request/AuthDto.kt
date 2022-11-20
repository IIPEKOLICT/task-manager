package taskmanager.backend.dtos.request

import taskmanager.backend.dtos.response.UserResponseDto

data class AuthDto(
    val token: String,
    val user: UserResponseDto
)
