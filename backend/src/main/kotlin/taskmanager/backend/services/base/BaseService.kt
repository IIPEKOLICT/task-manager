package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.base.BaseEntity

interface BaseService<E : BaseEntity> {
    suspend fun getAll(): List<E>
    suspend fun getById(id: ObjectId): E
    suspend fun deleteById(id: ObjectId): ObjectId
}