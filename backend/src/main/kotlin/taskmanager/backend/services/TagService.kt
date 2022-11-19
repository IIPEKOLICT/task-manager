package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.models.Tag
import taskmanager.backend.services.base.CreatedByUserEntityService

interface TagService : CreatedByUserEntityService<Tag> {
    suspend fun getByProject(projectId: ObjectId): List<Tag>
    suspend fun create(userId: ObjectId, projectId: ObjectId, name: String): Tag
    suspend fun updateById(id: ObjectId, name: String): Tag
    suspend fun deleteByProject(projectId: ObjectId)
}