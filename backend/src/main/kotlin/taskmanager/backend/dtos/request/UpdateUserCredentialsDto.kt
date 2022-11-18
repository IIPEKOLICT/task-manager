package taskmanager.backend.dtos.request

data class UpdateUserCredentialsDto(
    val email: String?,
    val password: String?
)
