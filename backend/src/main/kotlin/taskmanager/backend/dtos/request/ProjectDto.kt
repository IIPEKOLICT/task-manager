package taskmanager.backend.dtos.request

data class ProjectDto(
    val members: List<String>,
    val name: String
)
