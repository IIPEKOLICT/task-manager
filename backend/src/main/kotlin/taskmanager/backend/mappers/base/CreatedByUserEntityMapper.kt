package taskmanager.backend.mappers.base

import org.bson.types.ObjectId
import taskmanager.backend.models.User
import taskmanager.backend.models.interfaces.MappableCreatedByUserEntity
import taskmanager.backend.services.UserService

abstract class CreatedByUserEntityMapper<E : MappableCreatedByUserEntity<D>, D>(
    protected open val userService: UserService
) {

    private suspend fun getCreatedByUsers(entities: List<E>): List<User> {
        return userService.getByIds(entities.map { it.createdBy })
    }

    suspend fun convert(userId: ObjectId, entities: List<E>): List<D> {
        val createdByUsers: List<User> = getCreatedByUsers(entities)

        return entities.map { entity ->
            entity.toResponseDto(
                userId = userId,
                createdBy = createdByUsers.find {
                    it._id.toString() == entity.createdBy.toString()
                }
            )
        }
    }

    suspend fun convert(userId: ObjectId, entity: E): D {
        return convert(userId, listOf(entity))[0]
    }
}