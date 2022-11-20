package taskmanager.backend.dtos.request

data class WorkDto(
    val description: String,
    val startDate: String,
    val endDate: String
)
