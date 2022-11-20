package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.CreateAttachmentDto
import taskmanager.backend.models.Attachment
import taskmanager.backend.services.base.AttachedToTaskEntityService

interface AttachmentService : AttachedToTaskEntityService<Attachment> {
    suspend fun create(userId: ObjectId, taskId: ObjectId, dto: CreateAttachmentDto): Attachment
}