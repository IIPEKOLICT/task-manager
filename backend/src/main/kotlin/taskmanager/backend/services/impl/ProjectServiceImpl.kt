package taskmanager.backend.services.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.coroutine.CoroutineDatabase
import taskmanager.backend.dtos.request.CreateProjectDto
import taskmanager.backend.enums.DBCollection
import taskmanager.backend.exceptions.custom.EntityNotFoundException
import taskmanager.backend.models.Project
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl

class ProjectServiceImpl(
    database: CoroutineDatabase
) : CreatedByUserEntityServiceImpl<Project>(), ProjectService {

    private val collection: CoroutineCollection<Project> = database.getCollection(
        DBCollection.PROJECT.collectionName
    )

    private val notFoundException = EntityNotFoundException(DBCollection.PROJECT.entityName)

    override suspend fun getAll(): List<Project> {
        return collection.find().toList()
    }

    override suspend fun getByUser(userId: ObjectId): List<Project> {
        return collection
            .find(or(Project::createdBy eq userId, Project::members contains userId))
            .toList()
    }

    override suspend fun getById(id: ObjectId): Project {
        return collection.findOneById(id) ?: throw notFoundException
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
                update = setValue(Project::name, name),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun updateMembers(id: ObjectId, members: List<ObjectId>): Project {
        return collection
            .findOneAndUpdate(
                filter = Project::_id eq id,
                update = setValue(Project::members, members.toSet()),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteById(id: ObjectId): String {
        return collection.findOneAndDelete(Project::_id eq id)?._id?.toString()
            ?: throw notFoundException
    }

    override suspend fun deleteByUser(userId: ObjectId) {
        collection.deleteMany(Project::createdBy eq userId)
    }
}