package taskmanager.backend.dtos

data class CreateUserDto(
    val email: String,
    val password: String,
    val firstName: String,
    val lastName: String,
)
