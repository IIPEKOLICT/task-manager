package taskmanager.backend.services.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.dtos.request.CreateProjectDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Project
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl
import java.util.*

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
        return collection
            .findOneAndUpdate(
                filter = Project::_id eq id,
                update = set(
                    SetTo(Project::name, name),
                    SetTo(Project::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun updateMembers(id: ObjectId, members: List<ObjectId>): Project {
        return collection
            .findOneAndUpdate(
                filter = Project::_id eq id,
                update = set(
                    SetTo(Project::members, members.toSet()),
                    SetTo(Project::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteByUser(userId: ObjectId) {
        collection.deleteMany(Project::createdBy eq userId)
    }
}