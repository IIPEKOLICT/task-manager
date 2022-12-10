package taskmanager.backend.models

import org.bson.types.ObjectId
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.dtos.response.AttachmentResponseDto
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import taskmanager.backend.services.S3Service

data class Attachment(
    override val createdBy: ObjectId,
    override val task: ObjectId,

    var type: String,
    var path: String,
    var name: String
) : BaseEntityImpl(), AttachedToTaskEntity {

    fun toResponseDto(userId: ObjectId): AttachmentResponseDto {
        return AttachmentResponseDto(
            _id = _id.toString(),
            createdBy = createdBy.toString(),
            task = task.toString(),
            type = type,
            name = name,
            url = s3Service.getUrlOrNull(path),
            createdAt = createdAt,
            updatedAt = updatedAt,
            canEdit = userId.toString() == createdBy.toString()
        )
    }

    companion object {

        private val s3Service by inject<S3Service>(S3Service::class.java)
    }
}