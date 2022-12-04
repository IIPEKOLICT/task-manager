package taskmanager.backend.dtos.request

import taskmanager.backend.enums.Priority
import taskmanager.backend.enums.Status

data class CreateTaskDto(
    val assignedTo: String,
    val blockedBy: List<String> = emptyList(),
    val tags: List<String> = emptyList(),
    val title: String,
    val description: String,
    val priority: String,
    val status: String,
    val expectedHours: Int?
) {

    fun validate() {
        Priority.valueOf(priority)
        Status.valueOf(status)
    }
}