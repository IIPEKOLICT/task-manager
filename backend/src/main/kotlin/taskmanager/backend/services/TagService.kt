package taskmanager.backend.services

import org.bson.types.ObjectId
import taskmanager.backend.models.Tag
import taskmanager.backend.services.base.AttachedToProjectEntityService

interface TagService : AttachedToProjectEntityService<Tag> {
    suspend fun getByIds(ids: List<ObjectId>): List<Tag>
    suspend fun create(userId: ObjectId, projectId: ObjectId, name: String): Tag
    suspend fun updateById(id: ObjectId, name: String): Tag
}