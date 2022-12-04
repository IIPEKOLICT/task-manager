package taskmanager.backend.dtos.response

import taskmanager.backend.models.Tag
import java.util.Date

data class TaskResponseDto(
    val _id: String,
    val createdBy: String,
    val project: String,
    val assignedTo: UserResponseDto?,
    val blockedBy: List<String>,
    val trackedTime: Long,
    val commentsAmount: Int,
    val notesAmount: Int,
    val attachmentsAmount: Int,
    val tags: List<Tag>,
    val title: String,
    val description: String,
    val color: String,
    val priority: String,
    val status: String,
    val expectedHours: Int,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
