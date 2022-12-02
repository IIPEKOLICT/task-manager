package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.ProjectResponseDto
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.CreatedByUserEntity

data class Project(
    override val createdBy: ObjectId,
    val members: Set<ObjectId> = emptySet(),

    var name: String,
) : BaseEntityImpl(), CreatedByUserEntity {

    fun toResponse(userId: ObjectId): ProjectResponseDto {
        return ProjectResponseDto(
            _id = _id.toString(),
            createdBy = createdBy.toString(),
            members = members.map { it.toString() }.toSet(),
            name = name,
            createdAt = createdAt,
            updatedAt = updatedAt,
            canEdit = userId.toString() == createdBy.toString()
        )
    }
}