package taskmanager.backend.models

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.CommentResponseDto
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity

data class Comment(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var text: String
) : BaseEntityImpl(), AttachedToTaskEntity {

    fun toResponseDto(userId: ObjectId, createdBy: User?): CommentResponseDto {
        return CommentResponseDto(
            _id = _id.toString(),
            createdBy = createdBy?.toResponseDto(),
            task = task.toString(),
            text = text,
            createdAt = createdAt,
            updatedAt = updatedAt,
            canEdit = userId.toString() == userId.toString()
        )
    }
}