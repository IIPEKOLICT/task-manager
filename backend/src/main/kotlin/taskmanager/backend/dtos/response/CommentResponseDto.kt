package taskmanager.backend.dtos.response

import java.util.Date

data class CommentResponseDto(
    val _id: String,
    val createdBy: UserResponseDto?,
    val task: String,
    val text: String,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
