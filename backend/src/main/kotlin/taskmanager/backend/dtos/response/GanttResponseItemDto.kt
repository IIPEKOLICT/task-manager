package taskmanager.backend.dtos.response

data class GanttResponseItemDto(
    val taskName: String,
    val taskColor: String,
    val taskId: String,
    val hours: Int,
    val startOffsetHours: Int,
    val endOffsetHours: Int,
)
