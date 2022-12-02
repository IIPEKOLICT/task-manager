package taskmanager.backend.dtos.response

import java.util.Date

data class ProjectResponseDto(
    val _id: String,
    val createdBy: String,
    val members: Set<String>,
    val name: String,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
