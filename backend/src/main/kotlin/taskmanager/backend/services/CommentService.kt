package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.models.Comment
import taskmanager.backend.services.base.AttachedToTaskEntityService

interface CommentService : AttachedToTaskEntityService<Comment> {
    suspend fun create(userId: ObjectId, taskId: ObjectId, text: String): Comment
    suspend fun updateById(id: ObjectId, text: String): Comment
}