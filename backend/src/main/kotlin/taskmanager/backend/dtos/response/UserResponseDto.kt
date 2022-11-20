package taskmanager.backend.dtos.response

data class UserResponseDto(
    val _id: String,
    val email: String,
    val firstName: String,
    val lastName: String,
    val profilePicture: String? = null,
)
