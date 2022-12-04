package taskmanager.backend.dtos.request

data class UpdateTaskInfoDto(
    val title: String,
    val description: String,
    val expectedHours: Int?
)
