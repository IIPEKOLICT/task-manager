package taskmanager.backend.dtos.response

import java.util.Date

data class WorkResponseDto(
    val _id: String,
    val createdBy: UserResponseDto?,
    val task: String,
    val description: String,
    val startDate: Date,
    val endDate: Date,
    val createdAt: Date,
    val updatedAt: Date?,
    val canEdit: Boolean
)
