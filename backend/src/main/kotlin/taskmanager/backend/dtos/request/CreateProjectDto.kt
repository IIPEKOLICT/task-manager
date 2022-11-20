package taskmanager.backend.dtos.request

data class CreateProjectDto(
    val members: List<String>,
    val name: String
)
