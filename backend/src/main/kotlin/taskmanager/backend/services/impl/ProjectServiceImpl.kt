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
import taskmanager.backend.models.User
import taskmanager.backend.services.ProjectService

class ProjectServiceImpl(database: CoroutineDatabase) : ProjectService {

    private val collection: CoroutineCollection<Project> = database.getCollection(DBCollection.PROJECT.nameInDB)
    private val notFoundException = EntityNotFoundException(DBCollection.PROJECT.entityName)

    override suspend fun getAll(): List<Project> {
        return collection.find().toList()
    }

    override suspend fun getByUser(userId: ObjectId): List<Project> {
        return collection.find(User::_id eq userId).toList()
    }

    override suspend fun getById(id: String): Project {
        return collection.findOneById(ObjectId(id)) ?: throw notFoundException
    }

    override suspend fun isOwner(id: String, userId: ObjectId): Boolean {
        return getById(id).createdBy.toString() == userId.toString()
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

    override suspend fun updateName(id: String, name: String): Project {
        return collection
            .findOneAndUpdate(
                filter = Project::_id eq ObjectId(id),
                update = setValue(Project::name, name),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun updateMembers(id: String, members: List<ObjectId>): Project {
        return collection
            .findOneAndUpdate(
                filter = Project::_id eq ObjectId(id),
                update = setValue(Project::members, members.toSet()),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteById(id: String): String {
        return collection.findOneAndDelete(Project::_id eq ObjectId(id))?._id?.toString()
            ?: throw notFoundException
    }

    override suspend fun deleteByUser(userId: ObjectId) {
        collection.deleteMany(Project::createdBy eq userId)
    }
}