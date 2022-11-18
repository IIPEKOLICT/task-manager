package taskmanager.backend.models

import org.bson.codecs.pojo.annotations.BsonId
import org.bson.types.ObjectId
import taskmanager.backend.models.base.BaseEntity

data class Project(
    @BsonId val _id: ObjectId = ObjectId(),
    val createdBy: ObjectId,
    val members: Set<ObjectId> = emptySet(),
    val tasks: Set<ObjectId> = emptySet(),
    val tags: Set<ObjectId> = emptySet(),

    var name: String,
) : BaseEntity<Project>()