package taskmanager.backend.dtos.response

import java.util.Date

data class NoteResponseDto(
    val _id: String,
    val createdBy: UserResponseDto?,
    val task: String,
    val header: String,
    val text: String,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
