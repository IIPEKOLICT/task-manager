package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.dtos.request.CreateAttachmentDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Attachment
import taskmanager.backend.services.AttachmentService
import taskmanager.backend.services.base.impl.AttachedToTaskEntityServiceImpl

class AttachmentServiceImpl(
    override val collection: CoroutineCollection<Attachment>
) : AttachedToTaskEntityServiceImpl<Attachment>(collection, CollectionInfo.ATTACHMENT), AttachmentService {

    override suspend fun create(userId: ObjectId, taskId: ObjectId, dto: CreateAttachmentDto): Attachment {
        val attachment = Attachment(
            createdBy = userId,
            task = taskId,
            name = dto.name,
            type = dto.type,
            path = dto.path
        )

        collection.save(attachment)
        return attachment
    }
}