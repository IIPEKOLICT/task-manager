package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.AttachedToTaskEntity

interface AttachedToTaskEntityService<E : AttachedToTaskEntity> : CreatedByUserEntityService<E> {
    suspend fun getByTask(taskId: ObjectId): List<E>
    suspend fun deleteByTask(taskId: ObjectId)
}