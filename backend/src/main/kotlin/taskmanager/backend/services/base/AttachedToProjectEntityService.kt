package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.AttachedToProjectEntity

interface AttachedToProjectEntityService<E : AttachedToProjectEntity> : CreatedByUserEntityService<E> {
    suspend fun getByProject(projectId: ObjectId): List<E>
    suspend fun deleteByProject(projectId: ObjectId)
}