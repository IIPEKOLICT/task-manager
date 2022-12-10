package taskmanager.backend.dtos.response

data class GanttResponseDto(
    val hours: Int,
    val items: List<GanttResponseItemDto>,
)
