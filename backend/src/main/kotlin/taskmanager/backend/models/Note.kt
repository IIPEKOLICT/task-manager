package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.NoteResponseDto
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import taskmanager.backend.models.interfaces.MappableCreatedByUserEntity

data class Note(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var header: String,
    var text: String
) : BaseEntityImpl(), AttachedToTaskEntity, MappableCreatedByUserEntity<NoteResponseDto> {

    override fun toResponseDto(userId: ObjectId, createdBy: User?): NoteResponseDto {
        return NoteResponseDto(
            _id = _id.toString(),
            createdBy = createdBy?.toResponseDto(),
            task = task.toString(),
            header = header,
            text = text,
            createdAt = createdAt,
            updatedAt = updatedAt,
            canEdit = userId.toString() == userId.toString()
        )
    }
}