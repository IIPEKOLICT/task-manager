package taskmanager.backend.dtos.response

import java.util.*

data class AttachmentResponseDto(
    val _id: String,
    val type: String,
    val name: String,
    val url: String?,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
