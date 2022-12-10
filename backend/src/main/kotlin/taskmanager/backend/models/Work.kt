package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.WorkResponseDto
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import taskmanager.backend.models.interfaces.MappableCreatedByUserEntity
import java.util.Date

data class Work(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var description: String,
    var startDate: Date,
    var endDate: Date
) : BaseEntityImpl(), AttachedToTaskEntity, MappableCreatedByUserEntity<WorkResponseDto> {

    override fun toResponseDto(userId: ObjectId, createdBy: User?): WorkResponseDto {
        return WorkResponseDto(
            _id = _id.toString(),
            createdBy = createdBy?.toResponseDto(),
            task = task.toString(),
            description = description,
            startDate = startDate,
            endDate = endDate,
            createdAt = createdAt,
            updatedAt = updatedAt,
            canEdit = userId.toString() == userId.toString()
        )
    }
}