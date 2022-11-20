package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.dtos.request.CreateProjectDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Project
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl

class ProjectServiceImpl(
    override val collection: CoroutineCollection<Project>
) : CreatedByUserEntityServiceImpl<Project>(collection, CollectionInfo.PROJECT), ProjectService {

    override suspend fun getByUser(userId: ObjectId): List<Project> {
        return collection
            .find(or(Project::createdBy eq userId, Project::members contains userId))
            .toList()
    }

    override suspend fun create(userId: ObjectId, dto: CreateProjectDto): Project {
        val project = Project(
            createdBy = userId,
            members = dto.members.map { ObjectId(it) }.toSet(),
            name = dto.name
        )

        collection.save(project)
        return project
    }

    override suspend fun updateName(id: ObjectId, name: String): Project {
        return updateById(id, setValue(Project::name, name))
    }

    override suspend fun updateMembers(id: ObjectId, members: List<ObjectId>): Project {
        return updateById(id, setValue(Project::members, members.toSet()))
    }

    override suspend fun deleteByUser(userId: ObjectId) {
        collection.deleteMany(Project::createdBy eq userId)
    }
}